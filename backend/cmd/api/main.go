package main

import (
	"skillhub-backend/internal/config"
	"skillhub-backend/internal/domain"
	"skillhub-backend/internal/handler"
	"skillhub-backend/internal/middleware"
	"skillhub-backend/internal/repository"
	"skillhub-backend/internal/service"
	"skillhub-backend/pkg/utils"

	_ "skillhub-backend/docs" // Swagger docs (swag init ile oluşacak)

	echojwt "github.com/labstack/echo-jwt/v4"
	"github.com/labstack/echo/v4"
	echoSwagger "github.com/swaggo/echo-swagger"
)

// @title SkillHub API
// @version 1.0
// @description Turkcell SkillHub projesi için Backend API dokümantasyonu.
// @termsOfService http://swagger.io/terms/

// @contact.name API Destek
// @contact.url http://www.skillhub.com
// @contact.email support@skillhub.com

// @license.name Apache 2.0
// @license.url http://www.apache.org/licenses/LICENSE-2.0.html

// @host localhost:8080
// @BasePath /

// @securityDefinitions.apikey ApiKeyAuth
// @in header
// @name Authorization
func main() {
	// 1. DB Bağlantısı (PostgreSQL)
	db := config.ConnectDB()

	// Auto Migrate (Tabloları oluştur)
	// User, Category ve Lesson tablolarını garantiye alıyoruz.
	db.AutoMigrate(&domain.User{}, &domain.Category{}, &domain.Lesson{})

	// 2. Dependency Injection (Bağımlılıkları Bağlama)
	
	// --- USER MODÜLÜ ---
	userRepo := repository.NewUserRepository(db)
	authService := service.NewAuthService(userRepo)
	userService := service.NewUserService(userRepo)
	userHandler := handler.NewUserHandler(authService, userService)

	// --- CATEGORY MODÜLÜ ---
	categoryRepo := repository.NewCategoryRepository(db)
	categoryService := service.NewCategoryService(categoryRepo)
	categoryHandler := handler.NewCategoryHandler(categoryService)

	// --- LESSON MODÜLÜ (YENİ EKLENDİ) ---
	lessonRepo := repository.NewLessonRepository(db)
	lessonService := service.NewLessonService(lessonRepo)
	lessonHandler := handler.NewLessonHandler(lessonService)

	// 3. Echo Setup
	e := echo.New()

	// Swagger Endpoint
	e.GET("/swagger/*", echoSwagger.WrapHandler)

	// ---------------------------------------------------------
	// 4. PUBLIC ROUTES (Token Gerekmez - Herkese Açık)
	// ---------------------------------------------------------
	
	// Auth İşlemleri
	e.POST("/register", userHandler.Register)
	e.POST("/login", userHandler.Login)

	// Katalog (Kategoriler ve Dersler herkes tarafından görülebilir)
	e.GET("/categories", categoryHandler.GetAll)
	e.GET("/categories/:id", categoryHandler.GetByID)

	e.GET("/lessons", lessonHandler.GetAll)       // <--- YENİ (Dersleri Listele)
	e.GET("/lessons/:id", lessonHandler.GetByID)  // <--- YENİ (Ders Detayı)

	// ---------------------------------------------------------
	// 5. PROTECTED ROUTES (Token Zorunlu - Kilitli Alan)
	// ---------------------------------------------------------
	r := e.Group("/api")

	// JWT Middleware Ayarı
	config := echojwt.Config{
		SigningKey: utils.JWTSecret, // utils paketindeki gizli anahtar
	}
	r.Use(echojwt.WithConfig(config))

	// A. Genel Korumalı Rotalar
	r.PUT("/complete-profile", userHandler.CompleteProfile)

	// B. İçerik Yönetimi (Sadece giriş yapmış kullanıcılar)
	// Not: Gerçek senaryoda Admin rolü gerekir.
	
	// Kategori Yönetimi
	r.POST("/categories", categoryHandler.Create)
	r.PUT("/categories/:id", categoryHandler.Update)
	r.DELETE("/categories/:id", categoryHandler.Delete)

	// Ders Yönetimi (YENİ EKLENDİ)
	r.POST("/lessons", lessonHandler.Create)
	r.PUT("/lessons/:id", lessonHandler.Update)
	r.DELETE("/lessons/:id", lessonHandler.Delete)

	// C. Tam Profil Gerektiren Rotalar (Secure Group)
	// Bu gruba erişmek için hem Token lazım hem de Profil (Şehir/Üni) dolu olmalı.
	secureGroup := r.Group("/secure")
	secureGroup.Use(middleware.ProfileCompletionMiddleware(userRepo))

	secureGroup.GET("/me", userHandler.GetProfile)
	secureGroup.DELETE("/me", userHandler.DeleteUser)

	// Sunucuyu Başlat
	e.Logger.Fatal(e.Start(":8080"))
}