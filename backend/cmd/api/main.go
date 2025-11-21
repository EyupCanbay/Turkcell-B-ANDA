package main

import (
	"skillhub-backend/internal/config"
	"skillhub-backend/internal/domain"
	"skillhub-backend/internal/handler"
	"skillhub-backend/internal/middleware"
	"skillhub-backend/internal/repository"
	"skillhub-backend/internal/service"
	"skillhub-backend/pkg/utils"

	middlewareEcho "github.com/labstack/echo/v4/middleware"

	_ "skillhub-backend/docs"

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
	db := config.ConnectDB()


	db.AutoMigrate(
		&domain.User{},
		&domain.Category{},
		&domain.Lesson{},
		&domain.QuizQuestion{},
		&domain.QuizResult{},
		&domain.Leaderboard{}, 
	)


	userRepo := repository.NewUserRepository(db)
	authService := service.NewAuthService(userRepo)
	userService := service.NewUserService(userRepo)
	userHandler := handler.NewUserHandler(authService, userService)

	categoryRepo := repository.NewCategoryRepository(db)
	categoryService := service.NewCategoryService(categoryRepo)
	categoryHandler := handler.NewCategoryHandler(categoryService)

	lessonRepo := repository.NewLessonRepository(db)
	lessonService := service.NewLessonService(lessonRepo)
	lessonHandler := handler.NewLessonHandler(lessonService)

	quizRepo := repository.NewQuizRepository(db)
	quizService := service.NewQuizService(quizRepo)
	quizHandler := handler.NewQuizHandler(quizService)

	leaderboardRepo := repository.NewLeaderboardRepository(db)
	leaderboardService := service.NewLeaderboardService(leaderboardRepo)
	leaderboardHandler := handler.NewLeaderboardHandler(leaderboardService)

	e := echo.New()

	e.Use(middlewareEcho.CORSWithConfig(middlewareEcho.CORSConfig{
		AllowOrigins: []string{"*"}, 
		AllowMethods: []string{echo.GET, echo.PUT, echo.POST, echo.DELETE},
		AllowHeaders: []string{echo.HeaderOrigin, echo.HeaderContentType, echo.HeaderAccept, echo.HeaderAuthorization},
	}))

	e.GET("/swagger/*", echoSwagger.WrapHandler)


	e.POST("/register", userHandler.Register)
	e.POST("/login", userHandler.Login)

	e.GET("/categories", categoryHandler.GetAll)
	e.GET("/categories/:id", categoryHandler.GetByID)

	e.GET("/lessons", lessonHandler.GetAll)
	e.GET("/lessons/:id", lessonHandler.GetByID)

	e.GET("/lessons/:lesson_id/questions", quizHandler.GetQuestions)


	e.GET("/leaderboard", leaderboardHandler.GetTopUsers)

	r := e.Group("/api")

	config := echojwt.Config{
		SigningKey: utils.JWTSecret,
	}
	r.Use(echojwt.WithConfig(config))

	r.PUT("/complete-profile", userHandler.CompleteProfile)


	r.POST("/categories", categoryHandler.Create)
	r.PUT("/categories/:id", categoryHandler.Update)
	r.DELETE("/categories/:id", categoryHandler.Delete)

	r.POST("/lessons", lessonHandler.Create)
	r.PUT("/lessons/:id", lessonHandler.Update)
	r.DELETE("/lessons/:id", lessonHandler.Delete)

	r.POST("/questions", quizHandler.CreateQuestion)
	r.POST("/lessons/:lesson_id/submit", quizHandler.Submit)


	secureGroup := r.Group("/secure")
	secureGroup.Use(middleware.ProfileCompletionMiddleware(userRepo))

	secureGroup.GET("/me", userHandler.GetProfile)
	secureGroup.DELETE("/me", userHandler.DeleteUser)


	e.Logger.Fatal(e.Start("0.0.0.0:8080"))
}
