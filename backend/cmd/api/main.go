package main

import (
	"skillhub-backend/internal/config"
	"skillhub-backend/internal/domain"
	"skillhub-backend/internal/handler"
	"skillhub-backend/internal/middleware"
	"skillhub-backend/internal/repository"
	"skillhub-backend/internal/service"
	"skillhub-backend/pkg/utils"

	emw "github.com/labstack/echo/v4/middleware" // Echo middleware (alias verildi)

	_ "skillhub-backend/docs" // Swagger docs

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

	// 1. DB Bağlantısı
	db := config.ConnectDB()

	// Tablolar
	db.AutoMigrate(&domain.User{}, &domain.Category{}, &domain.Lesson{})

	// -------------------------------
	// 2. Dependency Injection
	// -------------------------------

	// USER
	userRepo := repository.NewUserRepository(db)
	authService := service.NewAuthService(userRepo)
	userService := service.NewUserService(userRepo)
	userHandler := handler.NewUserHandler(authService, userService)

	// CATEGORY
	categoryRepo := repository.NewCategoryRepository(db)
	categoryService := service.NewCategoryService(categoryRepo)
	categoryHandler := handler.NewCategoryHandler(categoryService)

	// LESSON
	lessonRepo := repository.NewLessonRepository(db)
	lessonService := service.NewLessonService(lessonRepo)
	lessonHandler := handler.NewLessonHandler(lessonService)

	// -------------------------------
	// 3. Echo Setup
	// -------------------------------
	e := echo.New()

	// CORS Middleware
	e.Use(emw.CORSWithConfig(emw.CORSConfig{
		AllowOrigins: []string{"*"}, // Her yerden gelen isteği kabul et
		AllowMethods: []string{echo.GET, echo.PUT, echo.POST, echo.DELETE},
		AllowHeaders: []string{
			echo.HeaderOrigin,
			echo.HeaderContentType,
			echo.HeaderAccept,
			echo.HeaderAuthorization,
		},
	}))

	// Swagger
	e.GET("/swagger/*", echoSwagger.WrapHandler)

	// -------------------------------
	// 4. PUBLIC ROUTES
	// -------------------------------
	e.POST("/register", userHandler.Register)
	e.POST("/login", userHandler.Login)

	e.GET("/categories", categoryHandler.GetAll)
	e.GET("/categories/:id", categoryHandler.GetByID)

	e.GET("/lessons", lessonHandler.GetAll)
	e.GET("/lessons/:id", lessonHandler.GetByID)

	// -------------------------------
	// 5. PROTECTED ROUTES
	// -------------------------------
	r := e.Group("/api")

	// JWT Ayarı
	jwtConfig := echojwt.Config{
		SigningKey: utils.JWTSecret,
	}
	r.Use(echojwt.WithConfig(jwtConfig))

	// Genel korumalı
	r.PUT("/complete-profile", userHandler.CompleteProfile)

	// CATEGORY Yönetimi
	r.POST("/categories", categoryHandler.Create)
	r.PUT("/categories/:id", categoryHandler.Update)
	r.DELETE("/categories/:id", categoryHandler.Delete)

	// LESSON Yönetimi
	r.POST("/lessons", lessonHandler.Create)
	r.PUT("/lessons/:id", lessonHandler.Update)
	r.DELETE("/lessons/:id", lessonHandler.Delete)

	// -------------------------------
	// 6. SECURE ROUTES (Tam Profil Şart)
	// -------------------------------
	secureGroup := r.Group("/secure")
	secureGroup.Use(middleware.ProfileCompletionMiddleware(userRepo))

	secureGroup.GET("/me", userHandler.GetProfile)
	secureGroup.DELETE("/me", userHandler.DeleteUser)

	// -------------------------------
	// 7. Server Başlat
	// -------------------------------
	e.Logger.Fatal(e.Start("0.0.0.0:8080"))
}
