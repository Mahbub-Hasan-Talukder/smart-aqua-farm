abstract class LibraryDataSource {
  Future<List<Map<String, dynamic>>> fetchDiseases();
  Future<Map<String, dynamic>> fetchDiseaseDetails(String diseaseName);
}
