import 'package:smart_aqua_farm/core/services/auth_service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    final supabaseClient = getIt<AuthService>().getSupabaseClient();
    final result =
        await supabaseClient
            .from('disease_library')
            .select()
            .eq('name', diseaseName)
            .maybeSingle();

    if (result != null) {
      return result;
    } else {
      // Try to find a near match using ilike (case-insensitive partial match)
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
    }
  }
}
