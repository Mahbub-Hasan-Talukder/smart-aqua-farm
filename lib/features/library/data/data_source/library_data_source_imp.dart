import 'package:smart_aqua_farm/core/services/auth_service/auth_service.dart';

import '../../../../core/di/di.dart';
import 'library_data_source.dart';

class LibraryDataSourceImp implements LibraryDataSource {
  @override
  Future<List<Map<String, dynamic>>> fetchDiseases() async {
    final supabaseClient = getIt<AuthService>().getSupabaseClient();
    return await supabaseClient.from('disease_library').select();
  }

  @override
  Future<Map<String, dynamic>> fetchDiseaseDetails(String diseaseName) async {
    try {
      final supabaseClient = getIt<AuthService>().getSupabaseClient();
      final nearMatches = await supabaseClient
          .from('disease_library')
          .select()
          .ilike('name', '%$diseaseName%')
          .limit(1);
      if (nearMatches.isNotEmpty) {
        return nearMatches.first;
      } else {
        throw Exception('Disease not found');
      }
    } catch (e) {
      throw Exception('Error fetching disease details: $e');
    }
  }
}
