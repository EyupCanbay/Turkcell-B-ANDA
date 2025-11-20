package middleware

import (
	"net/http"
	"skillhub-backend/internal/domain"
	"github.com/golang-jwt/jwt/v5"
	"github.com/labstack/echo/v4"
)

// Bu middleware sadece "Authentication" geçmiş rotalarda kullanılır.
func ProfileCompletionMiddleware(repo domain.UserRepository) echo.MiddlewareFunc {
	return func(next echo.HandlerFunc) echo.HandlerFunc {
		return func(c echo.Context) error {
			// 1. Token'dan UserID'yi al (Echo JWT Middleware bunu user context'e koyar)
			userToken := c.Get("user").(*jwt.Token)
			claims := userToken.Claims.(jwt.MapClaims)
			userID := uint(claims["user_id"].(float64))

			// 2. DB'den kullanıcıyı çek
			user, err := repo.FindByID(userID)
			if err != nil {
				return echo.NewHTTPError(http.StatusUnauthorized, "Kullanıcı bulunamadı")
			}

			// 3. Profil Doluluk Kontrolü
			// Eğer şehir veya üniversite boşsa 406 (Not Acceptable) veya custom bir kod dön
			if user.City == "" || user.University == "" {
				return c.JSON(http.StatusNotAcceptable, map[string]string{
					"error_code": "PROFILE_INCOMPLETE",
					"message":    "Lütfen profil bilgilerinizi tamamlayın (Şehir, Üniversite vb.)",
				})
			}

			// Sorun yoksa devam et
			return next(c)
		}
	}
}