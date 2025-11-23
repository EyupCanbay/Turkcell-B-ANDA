package handler

import (
	"fmt"
	"net/http"
	"skillhub-backend/internal/domain"
	"strconv"

	"github.com/labstack/echo/v4"
)

type LeaderboardHandler struct {
	Service domain.LeaderboardService
}

func NewLeaderboardHandler(service domain.LeaderboardService) *LeaderboardHandler {
	return &LeaderboardHandler{Service: service}
}

// GetLeaderboard godoc
// @Summary Liderlik Tablosunu Getir
// @Description En yüksek puanlı kullanıcıları listeler. Şehir filtresi yapılabilir.
// @Tags Leaderboard
// @Produce json
// @Param limit query int false "Listelenecek Kişi Sayısı (Varsayılan: 10)"
// @Param city query string false "Şehir Filtresi (Örn: İstanbul)"
// @Success 200 {array} domain.LeaderboardResponse
// @Router /leaderboard [get]
func (h *LeaderboardHandler) GetTopUsers(c echo.Context) error {
	limit, _ := strconv.Atoi(c.QueryParam("limit"))
	if limit <= 0 {
		limit = 10
	}
	city := c.QueryParam("city")

	leaderboard, err := h.Service.GetLeaderboard(limit, city)
	if err != nil {
		// HATA DETAYINI KONSOLA VE EKRANA BASALIM
		fmt.Println("❌ LİDERLİK HATASI:", err)
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"message": "Veri çekilemedi",
			"error":   err.Error(), // Gerçek hatayı burada göreceğiz
		})
	}

	return c.JSON(http.StatusOK, leaderboard)
}
