package repository

import (
	"skillhub-backend/internal/domain"
	"gorm.io/gorm"
)

type leaderboardRepository struct {
	db *gorm.DB
}

func NewLeaderboardRepository(db *gorm.DB) domain.LeaderboardRepository {
	return &leaderboardRepository{db: db}
}

func (r *leaderboardRepository) GetTopUsers(limit int, city string) ([]domain.Leaderboard, error) {
	var leaderboard []domain.Leaderboard
	
	query := r.db.Preload("User").Model(&domain.Leaderboard{})

	// Eğer şehir filtresi geldiyse ekle
	if city != "" {
		query = query.Where("city = ?", city)
	}

	// En yüksek puana göre sırala ve limiti uygula
	err := query.Order("total_points DESC").Limit(limit).Find(&leaderboard).Error
	
	return leaderboard, err
}