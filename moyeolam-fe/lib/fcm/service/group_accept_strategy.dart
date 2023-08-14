import 'package:dio/dio.dart';
import 'package:youngjun/common/const/address_config.dart';

class GroupAcceptStrategy {
  final Dio _dio = Dio(BaseOptions(baseUrl: BASE_URL));


  // 현재 로그인된 사용자의 아이디를 가져오는 함수
  Future<int?> getCurrentUserId() async {
    // 로그인된 사용자의 아이디를 가져오는 로직을 추가
    return 2; // 임시로 지정한 값
  }

  Future<void> execute(int alarmGroupId, bool isAccepted, int fromMemberId ) async {
    try {
      // 현재 로그인된 사용자의 아이디 가져오기
      int? currentUserId = await getCurrentUserId();
      if (currentUserId == null) {
        print('사용자의 아이디를 가져오지 못했습니다.');
        return;
      }


      Response response = await _dio.get('/alerts');

      if (response.statusCode == 200) {
        if (isAccepted) {
          print(isAccepted);
          await approveGroup(currentUserId, fromMemberId, alarmGroupId);
        } else {
          print(isAccepted);
          await declineGroup(currentUserId, fromMemberId, alarmGroupId);
        }
      } else {
        // 초기 GET 요청이 실패한 경우 처리
        print('초기 GET 요청 실패');
      }
    } catch (e) {
      // 과정 중에 발생할 수 있는 예외 처리
      print('예외 발생?? GET 에러임?: $e');
    }
  }

  Future<void> approveGroup(int currentUserUserId, int? fromMemberId, int alarmGroupId) async {
    try {
      // 알람 그룹 수락을 위한 API 요청 수행
      Response response = await _dio.post('/alarmgroups/$alarmGroupId/approve', data: {
        "fromMemberId": fromMemberId,
        "toMemberId": currentUserUserId,
      });

      if (response.statusCode == 200) {
        print('수락 API 요청 성공');
        print('응답 데이터: ${response.data}');
      } else {
        print('수락 API 요청 실패');
      }
    } on DioError catch (e) {
      print('DioError 발생!!: $e');
    } catch (e) {
      print('알람그룹 수락 API 요청 예외 발생: $e');
    }
  }

  Future<void> declineGroup(int currentUserUserId, int fromMemberId, int alarmGroupId) async {
    try {
      // 알람 그룹 거절을 위한 API 요청 수행
      Response response = await _dio.post('/alarmgroups/$alarmGroupId/reject', data: {
        "fromMemberId": fromMemberId,
        "toMemberId": currentUserUserId,
      });

      if (response.statusCode == 200) {
        print('거절 API 요청 성공');
        print('응답 데이터: ${response.data}');
      } else {
        print('거절 API 요청 실패');
      }
    } on DioError catch (e) {
      print('DioError 발생!!: $e');
    } catch (e) {
      print('알람그룹 거절 API 요청 예외 발생: $e');
    }
  }
}
