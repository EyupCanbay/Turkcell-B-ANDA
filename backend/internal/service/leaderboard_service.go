package service

import (
	"skillhub-backend/internal/domain"
)

type leaderboardService struct {
	repo domain.LeaderboardRepository
}

func NewLeaderboardService(repo domain.LeaderboardRepository) domain.LeaderboardService {
	return &leaderboardService{repo: repo}
}

func (s *leaderboardService) GetLeaderboard(limit int, city string) ([]domain.LeaderboardResponse, error) {
	data, err := s.repo.GetTopUsers(limit, city)
	if err != nil {
		return nil, err
	}

	// Entity -> DTO Dönüşümü
	var response []domain.LeaderboardResponse
	for i, item := range data {
		response = append(response, domain.LeaderboardResponse{
			Rank:        i + 1, // 0. indeks 1. sıradır
			UserID:      item.UserID,
			Name:        item.User.Name,       // User tablosundan gelen isim
			BadgeCount:  1, // User tablosundan gelen rozet
			TotalPoints: item.TotalPoints,
			City:        item.City,
		})
	}
	return response, nil
}
