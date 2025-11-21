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

	// Preload("User") -> Domain struct içindeki "User" alanını doldurur.
	// O alan yoksa kod patlar.
	query := r.db.Preload("User").Model(&domain.Leaderboard{})

	if city != "" {
		query = query.Where("city = ?", city)
	}

	err := query.Order("total_points DESC").Limit(limit).Find(&leaderboard).Error

	return leaderboard, err
}
