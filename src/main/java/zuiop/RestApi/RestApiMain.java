package zuiop.RestApi;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class RestApiMain {

    //public static void main(String[] args) {
        //getApiCall();
    //}

    //(DNF)서버 정보를 조회 합니다.
//    public JSONObject getServers(){
//        String url = "";
//        url = SystemConstants.DNF_DOMAIN+"/"+SystemConstants.DNF_SERVERS_PATH+"?"+"apikey="+SystemConstants.DNF_KEY;
//        return getApiJsonCall(url);
//    }
//
//    //(DNF)케릭터들 정보를 조회 합니다.
//    public JSONObject getCharacters(){
//        String url = "";
//        String serverId = "";         //서버 아이디 : 해당 서버군 검색 all : 전체 서버군 통합 검색
//        String characterName="법사";   //캐릭터 명칭 (URL 인코딩 필요)
//        String jobId = "";            //캐릭터 직업 고유 코드
//        String jobGrowId = "";        //캐릭터 각성 직업 고유 코드 (jobId 필요)
//        String wordType="full";       //검색타입 동일 단어(match), 전문 검색(full) ※ full의 경우 최소 2자에서 최대 12자까지 이용 가능 - 기본값 match
//        String limit="5";             //반환 Row 수 (기본값: 10  MAX: 200)
//
//        url = SystemConstants.DNF_DOMAIN+"/"+SystemConstants.DNF_SERVERS_PATH+"?"+"apikey="+SystemConstants.DNF_KEY;
//        return getApiJsonCall(url);
//    }
//
//    //(DNF)케릭터 기본정보를 조회 합니다.
//    public JSONObject getCharacterInfo(){
//        String url = "";
//        String serverId = "";         //서버 아이디 : 해당 서버군 검색 all : 전체 서버군 통합 검색
//        String characterName="법사";   //캐릭터 명칭 (URL 인코딩 필요)
//        String jobId = "";            //캐릭터 직업 고유 코드
//        String jobGrowId = "";        //캐릭터 각성 직업 고유 코드 (jobId 필요)
//        String wordType="full";       //검색타입 동일 단어(match), 전문 검색(full) ※ full의 경우 최소 2자에서 최대 12자까지 이용 가능 - 기본값 match
//        String limit="5";             //반환 Row 수 (기본값: 10  MAX: 200)
//        //characterName = URLEncoder.encode(characterName,"UTF-8"); //한글 유니코드로 인코딩
//        url = SystemConstants.DNF_DOMAIN+"/"+SystemConstants.DNF_SERVERS_PATH+"?"+"apikey="+SystemConstants.DNF_KEY;
//        return getApiJsonCall(url);
//    }
//
//    /* Api jsonCall - Get */
//    public static JSONObject getApiJsonCall(String parameter_url) {
//        HttpURLConnection conn = null;
//        JSONObject responseJson = null;
//        //호출할 url
//        try {
//            URL url = new URL(parameter_url);
//            conn = (HttpURLConnection) url.openConnection();
//            conn.setRequestMethod("GET");
//            conn.setDoOutput(true);
//            conn.setRequestProperty("content-type", "application/json");
//            //conn.setRequestProperty("X-Auth-Token","토큰넣기"); //뭐지?
//
//            //여기서부터 호출 검사
//            int responseCode = conn.getResponseCode();
//            if (responseCode == 400) {
//                System.out.println("400:: 해당 명령을 실행할 수 없음");
//            } else if (responseCode == 401) {
//                System.out.println("401:: X-Auth-Token Header가 잘못됨");
//            } else if (responseCode == 500) {
//                System.out.println("500:: 서버 에러, 문의 필요");
//            } else { // 성공
//                // conn.getInputStream() 사용자가 입력하거나 호출한 스트림값 ex> 키보드
//                // 그런데 위 데이터들은 보통 byte 단위의 데이터들이다.
//                // InputStreamReader 은 위 스트림 데이터를 (Reader 스트림형태 = character단위)로 변화시켜주는 클래스이다.
//                // BufferedReader 는 위 character 데이터를 읽어서 내가원하는 입출력으로 구현해줌
//                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));  // [자바 입출력 함수]
//                StringBuilder sb = new StringBuilder();
//                String line = "";
//
//                // 한줄~한줄 쌓아서 json으로 바꾸기위한 빌드업
//                while ((line = br.readLine()) != null) {
//                    sb.append(line);
//                }
//
//                responseJson = new JSONObject(sb.toString());
//                System.out.printf(responseJson.toString());
//                br.close();
//                conn.disconnect();
//            }
//        }catch (IOException e){
//            e.printStackTrace();
//        }
//        return responseJson;
//    }

    /* Api xmlCall -Get */
    public static String getApiXmlCall(String parameter_url) {
        String xml = null;
        HttpURLConnection conn = null;
        StringBuilder sb = new StringBuilder();
        //호출할 url
        try {
            URL url = new URL(parameter_url);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setDoOutput(true);
            conn.setRequestProperty("content-type", "application/json");
            //conn.setRequestProperty("X-Auth-Token","토큰넣기"); //뭐지?

            //여기서부터 호출 검사
            int responseCode = conn.getResponseCode();
            if (responseCode == 400) {
                System.out.println("400:: 해당 명령을 실행할 수 없음");
            } else if (responseCode == 401) {
                System.out.println("401:: X-Auth-Token Header가 잘못됨");
            } else if (responseCode == 500) {
                System.out.println("500:: 서버 에러, 문의 필요");
            } else { // 성공
                // conn.getInputStream() 사용자가 입력하거나 호출한 스트림값 ex> 키보드
                // 그런데 위 데이터들은 보통 byte 단위의 데이터들이다.
                // InputStreamReader 은 위 스트림 데이터를 (Reader 스트림형태 = character단위)로 변화시켜주는 클래스이다.
                // BufferedReader 는 위 character 데이터를 읽어서 내가원하는 입출력으로 구현해줌
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));  // [자바 입출력 함수]
                String line = "";
                // 한줄~한줄 쌓아서 json으로 바꾸기위한 빌드업
                while ((line = br.readLine()) != null) {
                    sb.append(line);
                }
                br.close();
                conn.disconnect();
                xml = sb.toString();
            }
        }catch (IOException e){
            e.printStackTrace();
        }
        return xml;
    }
}
