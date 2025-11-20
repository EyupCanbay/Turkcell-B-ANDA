package handler

import (
	"net/http"
	"skillhub-backend/internal/domain"
	"strconv"
	"github.com/labstack/echo/v4"
)

type CategoryHandler struct {
	Service domain.CategoryService
}

func NewCategoryHandler(service domain.CategoryService) *CategoryHandler {
	return &CategoryHandler{Service: service}
}

// CreateCategory godoc
// @Summary Yeni Kategori Ekle
// @Description Sisteme yeni eğitim kategorisi ekler.
// @Tags Categories
// @Accept json
// @Produce json
// @Param Authorization header string true "Bearer Token"
// @Param request body domain.CreateCategoryRequest true "Kategori Bilgileri"
// @Success 201 {string} string "Kategori oluşturuldu"
// @Failure 400 {string} string "Hatalı veri"
// @Security ApiKeyAuth
// @Router /api/categories [post]
func (h *CategoryHandler) Create(c echo.Context) error {
	var req domain.CreateCategoryRequest
	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, "Geçersiz veri")
	}
	if err := h.Service.CreateCategory(&req); err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}
	return c.JSON(http.StatusCreated, "Kategori oluşturuldu")
}

// GetAllCategories godoc
// @Summary Tüm Kategorileri Listele
// @Description Sistemdeki aktif kategorileri getirir.
// @Tags Categories
// @Produce json
// @Success 200 {array} domain.CategoryResponse
// @Router /categories [get]
func (h *CategoryHandler) GetAll(c echo.Context) error {
	categories, err := h.Service.GetAllCategories()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, "Veri çekilemedi")
	}
	return c.JSON(http.StatusOK, categories)
}

// GetCategoryByID godoc
// @Summary ID ile Kategori Getir
// @Description Belirtilen ID'ye sahip kategoriyi döner.
// @Tags Categories
// @Produce json
// @Param id path int true "Kategori ID"
// @Success 200 {object} domain.CategoryResponse
// @Failure 404 {string} string "Kategori bulunamadı"
// @Router /categories/{id} [get]
func (h *CategoryHandler) GetByID(c echo.Context) error {
	id, _ := strconv.Atoi(c.Param("id"))
	category, err := h.Service.GetCategoryByID(uint(id))
	if err != nil {
		return c.JSON(http.StatusNotFound, "Kategori bulunamadı")
	}
	return c.JSON(http.StatusOK, category)
}

// UpdateCategory godoc
// @Summary Kategori Güncelle
// @Description Var olan bir kategoriyi günceller.
// @Tags Categories
// @Accept json
// @Produce json
// @Param Authorization header string true "Bearer Token"
// @Param id path int true "Kategori ID"
// @Param request body domain.UpdateCategoryRequest true "Güncelleme Bilgileri"
// @Success 200 {string} string "Kategori güncellendi"
// @Security ApiKeyAuth
// @Router /api/categories/{id} [put]
func (h *CategoryHandler) Update(c echo.Context) error {
	id, _ := strconv.Atoi(c.Param("id"))
	var req domain.UpdateCategoryRequest
	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, "Geçersiz veri")
	}
	if err := h.Service.UpdateCategory(uint(id), &req); err != nil {
		return c.JSON(http.StatusInternalServerError, "Güncelleme hatası")
	}
	return c.JSON(http.StatusOK, "Kategori güncellendi")
}

// DeleteCategory godoc
// @Summary Kategori Sil (Soft Delete)
// @Description Kategoriyi silinmiş olarak işaretler.
// @Tags Categories
// @Param Authorization header string true "Bearer Token"
// @Param id path int true "Kategori ID"
// @Success 200 {string} string "Kategori silindi"
// @Security ApiKeyAuth
// @Router /api/categories/{id} [delete]
func (h *CategoryHandler) Delete(c echo.Context) error {
	id, _ := strconv.Atoi(c.Param("id"))
	if err := h.Service.DeleteCategory(uint(id)); err != nil {
		return c.JSON(http.StatusInternalServerError, "Silme başarısız")
	}
	return c.JSON(http.StatusOK, "Kategori silindi")
}