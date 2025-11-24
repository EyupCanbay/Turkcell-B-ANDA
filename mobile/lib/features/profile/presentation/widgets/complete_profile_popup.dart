import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/profile_bloc.dart';

class CompleteProfilePopup extends StatefulWidget {
  final String? currentCity;
  final String? currentUniversity;
  final String? currentSkill;

  const CompleteProfilePopup({
    super.key,
    this.currentCity,
    this.currentUniversity,
    this.currentSkill,
  });

  @override
  State<CompleteProfilePopup> createState() => _CompleteProfilePopupState();
}

class _CompleteProfilePopupState extends State<CompleteProfilePopup> {
  late TextEditingController _cityController;
  late TextEditingController _universityController;
  String _selectedSkill = 'Başlangıç';

  final List<String> _skillLevels = ['Başlangıç', 'Orta', 'İleri', 'Uzman'];

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController(text: widget.currentCity);
    _universityController =
        TextEditingController(text: widget.currentUniversity);
    if (widget.currentSkill != null &&
        _skillLevels.contains(widget.currentSkill)) {
      _selectedSkill = widget.currentSkill!;
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    _universityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cardLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Başlık
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit_note,
                      color: AppColors.designYellow),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Profili Tamamla",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                    fontFamily: 'Plus Jakarta Sans',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Şehir Input
            _buildTextField(
              controller: _cityController,
              label: "Şehir",
              icon: Icons.location_city,
            ),
            const SizedBox(height: 16),

            // Üniversite Input
            _buildTextField(
              controller: _universityController,
              label: "Üniversite",
              icon: Icons.school,
            ),
            const SizedBox(height: 16),

            // Yetenek Seviyesi Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedSkill,
                  dropdownColor: AppColors.cardLight,
                  icon: const Icon(Icons.arrow_drop_down,
                      color: AppColors.textMain),
                  isExpanded: true,
                  style: const TextStyle(
                    color: AppColors.textMain,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Plus Jakarta Sans',
                  ),
                  items: _skillLevels.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSkill = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Kaydet Butonu
            ElevatedButton(
              onPressed: () {
                if (_cityController.text.isNotEmpty &&
                    _universityController.text.isNotEmpty) {
                  context.read<ProfileBloc>().add(
                        UpdateProfileEvent(
                          city: _cityController.text,
                          university: _universityController.text,
                          skillLevel: _selectedSkill,
                        ),
                      );
                  Navigator.pop(context); // Popup'ı kapat
                } else {
                  // Basit validasyon uyarısı
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Lütfen tüm alanları doldurun")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.designYellow,
                foregroundColor: AppColors.textMain,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text(
                "Kaydet ve Güncelle",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: AppColors.textMain),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textSub),
        prefixIcon: Icon(icon, color: AppColors.textSub),
        filled: true,
        fillColor: AppColors.backgroundLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.designYellow),
        ),
      ),
    );
  }
}
