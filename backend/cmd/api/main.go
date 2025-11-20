package main

import (
	"skillhub-backend/internal/config"
	"skillhub-backend/internal/domain"
	"skillhub-backend/internal/handler"
	"skillhub-backend/internal/middleware"
	"skillhub-backend/internal/repository"
	"skillhub-backend/internal/service"
	"skillhub-backend/pkg/utils"

	_ "skillhub-backend/docs" // Bu klasör birazdan oluşacak, kızarsa korkma!

	echoSwagger "github.com/swaggo/echo-swagger"

	echojwt "github.com/labstack/echo-jwt/v4"
	"github.com/labstack/echo/v4"
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
	// Auto Migrate (Tabloları koddan oluşturmak için - Production'da kapatılır)
	db.AutoMigrate(&domain.User{})

	// 2. Dependency Injection (Bağımlılıkları Elle Enjekte Ediyoruz)
	userRepo := repository.NewUserRepository(db)
	authService := service.NewAuthService(userRepo)
	userService := service.NewUserService(userRepo)
	userHandler := handler.NewUserHandler(authService, userService)

	// 3. Echo Setup
	e := echo.New()

	e.GET("/swagger/*", echoSwagger.WrapHandler)

	// 4. Public Routes (Herkese Açık)
	e.POST("/register", userHandler.Register)
	e.POST("/login", userHandler.Login)

	// 5. Protected Routes (JWT Gerektirir)
	r := e.Group("/api")

	// JWT Middleware'i (Token kontrolü)
	config := echojwt.Config{
		SigningKey: []byte(utils.JWTSecret), // Env dosyasından alınmalı
	}
	r.Use(echojwt.WithConfig(config))

	// a. Profil Tamamlama (Middleware takılmaz, çünkü burası zaten tamamlama yeri)
	r.PUT("/complete-profile", userHandler.CompleteProfile)

	// b. Tam Profil Gerektiren Rotalar
	// Bu gruba giren herkesin Şehir ve Üniversite bilgisi dolu olmak ZORUNDA.
	// Dolu değilse middleware hata fırlatır, mobilci "Profil Tamamla" ekranını açar.
	secureGroup := r.Group("/secure")
	secureGroup.Use(middleware.ProfileCompletionMiddleware(userRepo))

	secureGroup.GET("/me", userHandler.GetProfile)
	secureGroup.DELETE("/me", userHandler.DeleteUser)

	// Sunucuyu Başlat
	e.Logger.Fatal(e.Start(":8080"))
}
