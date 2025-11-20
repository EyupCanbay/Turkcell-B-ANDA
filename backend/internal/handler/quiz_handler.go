package handler

import (
	"net/http"
	"skillhub-backend/internal/domain"
	"strconv"

	"github.com/golang-jwt/jwt/v5"
	"github.com/labstack/echo/v4"
)

type QuizHandler struct {
	Service domain.QuizService
}

func NewQuizHandler(service domain.QuizService) *QuizHandler {
	return &QuizHandler{Service: service}
}

// CreateQuestion godoc
// @Summary Soru Ekle
// @Tags Quiz
// @Accept json
// @Produce json
// @Param Authorization header string true "Bearer Token"
// @Param request body domain.CreateQuestionRequest true "Soru Detayları"
// @Success 201 {string} string "Soru eklendi"
// @Security ApiKeyAuth
// @Router /api/questions [post]
func (h *QuizHandler) CreateQuestion(c echo.Context) error {
	var req domain.CreateQuestionRequest
	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, "Geçersiz veri")
	}
	if err := h.Service.AddQuestion(&req); err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}
	return c.JSON(http.StatusCreated, "Soru eklendi")
}

// GetQuestions godoc
// @Summary Dersin Sorularını Getir
// @Tags Quiz
// @Produce json
// @Param lesson_id path int true "Ders ID"
// @Success 200 {array} domain.QuizQuestion
// @Router /lessons/{lesson_id}/questions [get]
func (h *QuizHandler) GetQuestions(c echo.Context) error {
	lessonID, _ := strconv.Atoi(c.Param("lesson_id"))
	questions, err := h.Service.GetQuestions(uint(lessonID))
	if err != nil {
		return c.JSON(http.StatusNotFound, "Soru bulunamadı")
	}
	// Not: Gerçek prod ortamında 'CorrectAnswer' alanını 
	// burada JSON'dan gizlemek (omit) gerekir, kopya çekilmesin diye.
	return c.JSON(http.StatusOK, questions)
}

// SubmitQuiz godoc
// @Summary Quiz Cevapla ve Puanla
// @Description Kullanıcı cevaplarını gönderir, sistem puanlar ve kaydeder.
// @Tags Quiz
// @Accept json
// @Produce json
// @Param Authorization header string true "Bearer Token"
// @Param lesson_id path int true "Ders ID"
// @Param request body domain.SubmitQuizRequest true "Cevaplar"
// @Success 200 {object} domain.QuizResultResponse
// @Security ApiKeyAuth
// @Router /api/lessons/{lesson_id}/submit [post]
func (h *QuizHandler) Submit(c echo.Context) error {
	// Token'dan User ID al
	userToken := c.Get("user").(*jwt.Token)
	claims := userToken.Claims.(jwt.MapClaims)
	userID := uint(claims["user_id"].(float64))

	// URL'den Lesson ID al
	lessonID, _ := strconv.Atoi(c.Param("lesson_id"))

	// Body'den cevapları al
	var req domain.SubmitQuizRequest
	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, "Geçersiz veri")
	}

	// Servise gönder
	result, err := h.Service.SubmitQuiz(userID, uint(lessonID), &req)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}

	return c.JSON(http.StatusOK, result)
}