import 'package:get/get.dart';
import 'package:health_monitoring_system/model/user_data_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsersController extends GetxController {
  final SupabaseClient _client = Supabase.instance.client;
  var users = <VaidyaiUser>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // fetchUsers();
  // }

  Future<void> fetchUsers(String userId) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // 1) Fetch the raw list (no generics, no .execute())

      final raw = await _client.from('vaidyai_users').select().eq('id', userId);

      // 2) Cast to List<Map<String, dynamic>>
      final rows = List<Map<String, dynamic>>.from(raw);

      // 3) Map into your model
      users.value = rows.map((json) => VaidyaiUser.fromJson(json)).toList();
    } on PostgrestException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
