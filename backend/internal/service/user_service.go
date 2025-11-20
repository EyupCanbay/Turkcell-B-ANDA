package service

import (
	"skillhub-backend/internal/domain"
)

type userService struct {
	repo domain.UserRepository
}

func NewUserService(repo domain.UserRepository) domain.UserService {
	return &userService{repo: repo}
}

func (s *userService) GetProfile(userID uint) (*domain.UserResponse, error) {
	user, err := s.repo.FindByID(userID)
	if err != nil {
		return nil, err
	}
	return &domain.UserResponse{
		ID: user.ID, Name: user.Name, Email: user.Email, City: user.City,
	}, nil
}

func (s *userService) UpdateProfile(userID uint, req *domain.UpdateProfileRequest) error {
	user, err := s.repo.FindByID(userID)
	if err != nil {
		return err
	}
	
	// Alanları güncelle
	user.City = req.City
	user.University = req.University
	user.SkillLevel = req.SkillLevel
	
	return s.repo.Update(user)
}

func (s *userService) DeleteUser(userID uint) error {
	return s.repo.Delete(userID)
}