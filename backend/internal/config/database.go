package config

import (
	"fmt"
	"log"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

// ConnectDB: Veritabanına bağlanır ve bağlantı nesnesini döner
func ConnectDB() *gorm.DB {
	// Docker'daki PostgreSQL bilgilerin:
	dsn := "host=localhost user=postgres password=password dbname=turkcell port=5432 sslmode=disable"

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Veritabanına bağlanılamadı! Hata:", err)
	}

	fmt.Println("🚀 Veritabanı bağlantısı başarılı!")
	return db
}
