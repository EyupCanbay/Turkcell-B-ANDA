package handler

import (
	"net/http"
	"skillhub-backend/internal/domain"
	"strconv"
	"github.com/labstack/echo/v4"
)

type LessonHandler struct {
	Service domain.LessonService
}

func NewLessonHandler(service domain.LessonService) *LessonHandler {
	return &LessonHandler{Service: service}
}

// CreateLesson godoc
// @Summary Yeni Ders Ekle
// @Description Bir kategoriye bağlı yeni ders ekler.
// @Tags Lessons
// @Accept json
// @Produce json
// @Param Authorization header string true "Bearer Token"
// @Param request body domain.CreateLessonRequest true "Ders Bilgileri"
// @Success 201 {string} string "Ders oluşturuldu"
// @Failure 400 {string} string "Hatalı veri"
// @Security ApiKeyAuth
// @Router /api/lessons [post]
func (h *LessonHandler) Create(c echo.Context) error {
	var req domain.CreateLessonRequest
	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, "Geçersiz veri")
	}
	if err := h.Service.CreateLesson(&req); err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}
	return c.JSON(http.StatusCreated, "Ders oluşturuldu")
}

// GetAllLessons godoc
// @Summary Tüm Dersleri Listele
// @Description Sistemdeki tüm dersleri getirir.
// @Tags Lessons
// @Produce json
// @Success 200 {array} domain.LessonResponse
// @Router /lessons [get]
func (h *LessonHandler) GetAll(c echo.Context) error {
	// Opsiyonel: Kategori filtresi (?category_id=1)
	catID := c.QueryParam("category_id")
	if catID != "" {
		id, _ := strconv.Atoi(catID)
		lessons, err := h.Service.GetLessonsByCategory(uint(id))
		if err != nil { return c.JSON(http.StatusNotFound, "Ders bulunamadı") }
		return c.JSON(http.StatusOK, lessons)
	}

	lessons, err := h.Service.GetAllLessons()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, "Veri çekilemedi")
	}
	return c.JSON(http.StatusOK, lessons)
}

// GetLessonByID godoc
// @Summary ID ile Ders Getir
// @Description Belirtilen ID'ye sahip dersi döner.
// @Tags Lessons
// @Produce json
// @Param id path int true "Ders ID"
// @Success 200 {object} domain.LessonResponse
// @Router /lessons/{id} [get]
func (h *LessonHandler) GetByID(c echo.Context) error {
	id, _ := strconv.Atoi(c.Param("id"))
	lesson, err := h.Service.GetLessonByID(uint(id))
	if err != nil {
		return c.JSON(http.StatusNotFound, "Ders bulunamadı")
	}
	return c.JSON(http.StatusOK, lesson)
}

// UpdateLesson godoc
// @Summary Ders Güncelle
// @Description Var olan bir dersi günceller.
// @Tags Lessons
// @Accept json
// @Produce json
// @Param Authorization header string true "Bearer Token"
// @Param id path int true "Ders ID"
// @Param request body domain.UpdateLessonRequest true "Güncelleme Bilgileri"
// @Success 200 {string} string "Ders güncellendi"
// @Security ApiKeyAuth
// @Router /api/lessons/{id} [put]
func (h *LessonHandler) Update(c echo.Context) error {
	id, _ := strconv.Atoi(c.Param("id"))
	var req domain.UpdateLessonRequest
	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, "Geçersiz veri")
	}
	if err := h.Service.UpdateLesson(uint(id), &req); err != nil {
		return c.JSON(http.StatusInternalServerError, "Güncelleme hatası")
	}
	return c.JSON(http.StatusOK, "Ders güncellendi")
}

// DeleteLesson godoc
// @Summary Ders Sil (Soft Delete)
// @Description Dersi silinmiş olarak işaretler.
// @Tags Lessons
// @Param Authorization header string true "Bearer Token"
// @Param id path int true "Ders ID"
// @Success 200 {string} string "Ders silindi"
// @Security ApiKeyAuth
// @Router /api/lessons/{id} [delete]
func (h *LessonHandler) Delete(c echo.Context) error {
	id, _ := strconv.Atoi(c.Param("id"))
	if err := h.Service.DeleteLesson(uint(id)); err != nil {
		return c.JSON(http.StatusInternalServerError, "Silme başarısız")
	}
	return c.JSON(http.StatusOK, "Ders silindi")
}