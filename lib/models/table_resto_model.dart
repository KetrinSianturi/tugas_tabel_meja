class TableRestoModel {
  final String kode;
  final String nama;
  final int kapasitas;

  TableRestoModel({
    required this.kode,
    required this.nama,
    required this.kapasitas,
  });

  // Tambahkan factory agar bisa parsing dari JSON jika backend digunakan
  factory TableRestoModel.fromJson(Map<String, dynamic> json) {
    return TableRestoModel(
      kode: json['kode'],
      nama: json['nama'],
      kapasitas: json['kapasitas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode': kode,
      'nama': nama,
      'kapasitas': kapasitas,
    };
  }
}
