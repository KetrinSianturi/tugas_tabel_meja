class TableRestoParam {
  final String kode;
  final String nama;
  final int kapasitas;

  TableRestoParam({
    required this.kode,
    required this.nama,
    required this.kapasitas,
  });

  Map<String, dynamic> toJson() => {
    'kode': kode,
    'nama': nama,
    'kapasitas': kapasitas,
  };
}
