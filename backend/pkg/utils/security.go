package utils

import (
	"time"

	"github.com/golang-jwt/jwt/v5"
	"golang.org/x/crypto/bcrypt"
)

// GİZLİ ANAHTAR (Normalde .env dosyasından gelir ama yarışma için buraya sabitledik)
var JWTSecret = []byte("SUPER_GIZLI_YARISMA_ANAHTARI")

// 1. Şifre Hashleme (Kayıt olurken kullanılır)
// "123456" -> "$2a$10$Xy..." gibi karmaşık bir şeye çevirir.
func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}

// 2. Şifre Doğrulama (Login olurken kullanılır)
// Kullanıcının girdiği "123456" ile veritabanındaki hash aynı mı bakar.
func CheckPassword(password, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}

// 3. JWT Token Üretme (Login başarılı olunca verilir)
func GenerateJWT(userID uint) (string, error) {
	// Token içinde neleri saklayacağız? (Claims)
	claims := jwt.MapClaims{
		"user_id": userID,
		"exp":     time.Now().Add(time.Hour * 72).Unix(), // 3 gün geçerli
	}

	// Token oluştur
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	// İmzala ve string olarak dön
	return token.SignedString(JWTSecret)
}
