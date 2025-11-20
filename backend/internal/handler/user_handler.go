package handler

import (
	"net/http"
	"skillhub-backend/internal/domain"
	"github.com/golang-jwt/jwt/v5"
	"github.com/labstack/echo/v4"
)

type UserHandler struct {
	AuthService domain.AuthService
	UserService domain.UserService
}

func NewUserHandler(as domain.AuthService, us domain.UserService) *UserHandler {
	return &UserHandler{AuthService: as, UserService: us}
}

// POST /register
// Register godoc
// @Summary Yeni Kullanıcı Kaydı
// @Description Sisteme yeni bir kullanıcı ekler.
// @Tags Auth
// @Accept json
// @Produce json
// @Param request body domain.RegisterRequest true "Kayıt Bilgileri"
// @Success 201 {string} string "Kayıt başarılı"
// @Failure 400 {string} string "Hatalı veri"
// @Failure 409 {string} string "Bu email zaten kullanımda"
// @Router /register [post]
func (h *UserHandler) Register(c echo.Context) error {
	var req domain.RegisterRequest
	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, "Geçersiz veri")
	}
	if err := h.AuthService.Register(&req); err != nil {
		return c.JSON(http.StatusConflict, err.Error())
	}
	return c.JSON(http.StatusCreated, "Kayıt başarılı")
}

// POST /login
// Login godoc
// @Summary Giriş Yap
// @Description Email ve şifre ile giriş yapar, JWT Token döner.
// @Tags Auth
// @Accept json
// @Produce json
// @Param request body domain.LoginRequest true "Giriş Bilgileri"
// @Success 200 {object} map[string]string
// @Failure 400 {string} string "Geçersiz veri"
// @Failure 401 {string} string "Giriş başarısız"
// @Router /login [post]
func (h *UserHandler) Login(c echo.Context) error {
	var req domain.LoginRequest
	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, "Geçersiz veri")
	}
	token, err := h.AuthService.Login(&req)
	if err != nil {
		return c.JSON(http.StatusUnauthorized, "Giriş başarısız")
	}
	return c.JSON(http.StatusOK, map[string]string{"token": token})
}

// PUT /profile (Eksik bilgileri tamamlamak için)
// CompleteProfile godoc
// @Summary Profil Tamamlama
// @Description Eksik olan şehir, üniversite ve yetenek bilgilerini günceller.
// @Tags User
// @Accept json
// @Produce json
// @Param Authorization header string true "Bearer Token"
// @Param request body domain.UpdateProfileRequest true "Profil Bilgileri"
// @Success 200 {string} string "Profil güncellendi"
// @Failure 400 {string} string "Eksik parametreler"
// @Security ApiKeyAuth
// @Router /api/complete-profile [put]
func (h *UserHandler) CompleteProfile(c echo.Context) error {
	userToken := c.Get("user").(*jwt.Token)
	claims := userToken.Claims.(jwt.MapClaims)
	userID := uint(claims["user_id"].(float64))

	var req domain.UpdateProfileRequest
	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, "Eksik parametreler")
	}

	if err := h.UserService.UpdateProfile(userID, &req); err != nil {
		return c.JSON(http.StatusInternalServerError, "Güncelleme hatası")
	}
	return c.JSON(http.StatusOK, "Profil güncellendi")
}

// GET /profile
// GetProfile godoc
// @Summary Profil Bilgilerini Getir
// @Description Giriş yapmış kullanıcının detaylarını döner.
// @Tags User
// @Accept json
// @Produce json
// @Param Authorization header string true "Bearer Token"
// @Success 200 {object} domain.UserResponse
// @Failure 401 {string} string "Yetkisiz işlem"
// @Failure 406 {string} string "Profil eksik (Tamamlanmalı)"
// @Security ApiKeyAuth
// @Router /api/secure/me [get]
func (h *UserHandler) GetProfile(c echo.Context) error {
	userToken := c.Get("user").(*jwt.Token)
	claims := userToken.Claims.(jwt.MapClaims)
	userID := uint(claims["user_id"].(float64))

	user, err := h.UserService.GetProfile(userID)
	if err != nil {
		return c.JSON(http.StatusNotFound, "Kullanıcı bulunamadı")
	}
	return c.JSON(http.StatusOK, user)
}

// DELETE /profile (Soft Delete)
// DeleteUser godoc
// @Summary Hesabı Sil (Soft Delete)
// @Description Kullanıcı hesabını silinmiş olarak işaretler.
// @Tags User
// @Accept json
// @Produce json
// @Param Authorization header string true "Bearer Token"
// @Success 200 {string} string "Hesabınız silindi"
// @Failure 500 {string} string "Silme başarısız"
// @Security ApiKeyAuth
// @Router /api/secure/me [delete]
func (h *UserHandler) DeleteUser(c echo.Context) error {
	userToken := c.Get("user").(*jwt.Token)
	claims := userToken.Claims.(jwt.MapClaims)
	userID := uint(claims["user_id"].(float64))

	if err := h.UserService.DeleteUser(userID); err != nil {
		return c.JSON(http.StatusInternalServerError, "Silme işlemi başarısız")
	}
	return c.JSON(http.StatusOK, "Hesabınız silindi (Soft Delete)")
}