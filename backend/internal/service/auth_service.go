package service

import (
	"errors"
	"skillhub-backend/internal/domain"
	"skillhub-backend/pkg/utils" // JWT ve Hash helper'ları

	"golang.org/x/crypto/bcrypt"
)

type authService struct {
	repo domain.UserRepository
}

func NewAuthService(repo domain.UserRepository) domain.AuthService {
	return &authService{repo: repo}
}

func (s *authService) Register(req *domain.RegisterRequest) error {
	// 1. Email kontrolü
	if _, err := s.repo.FindByEmail(req.Email); err == nil {
		return errors.New("bu email zaten kullanımda")
	}

	// 2. Şifre Hashleme
	hashedPass, _ := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)
	defaultSkill := "beginner"
	// 3. Mapping (DTO -> Entity)
	user := &domain.User{
		Name:       req.Name,
		Email:      req.Email,
		Password:   string(hashedPass),
		SkillLevel: defaultSkill,
	}

	return s.repo.Create(user)
}

func (s *authService) Login(req *domain.LoginRequest) (string, error) {
	user, err := s.repo.FindByEmail(req.Email)
	if err != nil {
		return "", errors.New("kullanıcı bulunamadı")
	}

	// Şifre Kontrolü
	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(req.Password)); err != nil {
		return "", errors.New("hatalı şifre")
	}

	// JWT Token Üret
	token, err := utils.GenerateJWT(user.ID)
	return token, err
}
