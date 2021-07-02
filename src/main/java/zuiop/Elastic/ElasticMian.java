package zuiop.Elastic;

import zuiop.System.SystemConstants;
import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.nio.client.HttpAsyncClientBuilder;
import org.apache.lucene.search.TotalHits;
import org.elasticsearch.action.admin.indices.create.CreateIndexRequest;
import org.elasticsearch.action.delete.DeleteRequest;
import org.elasticsearch.action.get.GetRequest;
import org.elasticsearch.action.get.GetResponse;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.update.UpdateRequest;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestClientBuilder;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.xcontent.XContentType;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.springframework.stereotype.Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Controller
public class ElasticMian {
    public static void main(String[] args) throws IOException {
        /* 엘라스틱 서취 기본 세팅 - 특이점 : 접근권한으로 인하여 UsernamePasswordCredentials 로 id,pw 적용 후 접속 */
        CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
        credentialsProvider.setCredentials(AuthScope.ANY,
                new UsernamePasswordCredentials(SystemConstants.ID, SystemConstants.PW));
        RestClientBuilder builder = RestClient.builder(
                new HttpHost(SystemConstants.SEARCH_HOST, SystemConstants.SEARCH_PORT))
                .setHttpClientConfigCallback(new RestClientBuilder.HttpClientConfigCallback() {
                    @Override
                    public HttpAsyncClientBuilder customizeHttpClient(HttpAsyncClientBuilder httpClientBuilder) {
                        return httpClientBuilder.setDefaultCredentialsProvider(credentialsProvider);
                    }
                });

        //RestHighLevelClient client = new RestHighLevelClient(RestClient.builder(new HttpHost("localhost",9200,"http")));
        RestHighLevelClient client = new RestHighLevelClient(builder);
        indexCreate(client);
        //documentCreate(client);
        //documentUpdate(client);
        //documentDelete(client);
        //GetResponse response = documentSearch(client);
        SearchResponse response = allSearch(client);
        //SearchResponse response = oneDtailSearch(client);
        //SearchResponse response = manyDtailSearch(client);
        System.out.printf(response.toString());
    }

    //index 생성 - 직접 소스로 날려볼까?
    public static void indexCreate(RestHighLevelClient client) throws IOException {
        String indexName = "game_index";
        CreateIndexRequest request = new CreateIndexRequest(indexName);

        // 메소드 고민
        // 인덱스 indexName 받자
        //

        request.settings(" {\n" +
                "    \"number_of_shards\": 5,\n" +
                "    \"number_of_replicas\": 1\n" +
                "  }",XContentType.JSON);

        request.mapping("planI","{\n" +
                "      \"properties\": {\n" +
                "        \"gameCd\": {\n" +
                "          \"type\": \"keyword\"\n" +
                "        },\n" +
                "        \"gameNm\": {\n" +
                "          \"type\": \"text\",\n" +
                "          \"analyzer\": \"standard\"\n" +
                "        },\n" +
                "        \"gameYear\": {\n" +
                "          \"type\": \"integer\"\n" +
                "        },\n" +
                "        \"gameType\": {\n" +
                "          \"type\": \"keyword\"\n" +
                "        },\n" +
                "        \"gameCompany\": {\n" +
                "          \"properties\": {\n" +
                "            \"companyCd\": {\n" +
                "              \"type\": \"keyword\"\n" +
                "            },\n" +
                "            \"companyNm\": {\n" +
                "               \"type\": \"text\",\n" +
                "               \"analyzer\": \"standard\"\n" +
                "            }\n" +
                "          }\n" +
                "        }\n" +
                "      }\n" +
                "  }",XContentType.JSON);

        client.indices().create(request, RequestOptions.DEFAULT).isAcknowledged();
    }

    //Document  생성 - POST /{index}/_doc/{id}
    public static void documentCreate(RestHighLevelClient client) throws IOException {
        Map<String,Object> map= new HashMap<String,Object>();
        map.put("gameCd","0001");
        map.put("gameNm","검은사막에 오아시스");
        map.put("gameYear","2015");
        map.put("gameType","RPG");
        map.put("companyCd","001_0001");
        map.put("companyNm","퍼러비스");

        Map<String,Object> map1= new HashMap<String,Object>();
        map1.put("gameCd","0002");
        map1.put("gameNm","메이플스토리 넥슨");
        map1.put("gameYear","2016");
        map1.put("gameType","RPG");
        map1.put("companyCd","002_0002");
        map1.put("companyNm","넥슨");

        Map<String,Object> map2= new HashMap<String,Object>();
        map2.put("gameCd","0003");
        map2.put("gameNm","서든어택 코마");
        map2.put("gameYear","2012");
        map2.put("gameType","FPS");
        map2.put("companyCd","002_0003");
        map2.put("companyNm","넥슨");

        Map<String,Object> map3= new HashMap<String,Object>();
        map3.put("gameCd","0004");
        map3.put("gameNm","리니지 미리네");
        map3.put("gameYear","2009");
        map3.put("gameType","RPG");
        map3.put("companyCd","003_0004");
        map3.put("companyNm","NC소프트");

        Map<String,Object> map4= new HashMap<String,Object>();
        map4.put("gameCd","0005");
        map4.put("gameNm","배틀그라운드 아저씨");
        map4.put("gameYear","2019");
        map4.put("gameType","FPS");
        map4.put("companyCd","004_0005");
        map4.put("companyNm","크래프톤");

        Map<String,Object> map5= new HashMap<String,Object>();
        map5.put("gameCd","0006");
        map5.put("gameNm","리니지와 서태지와 아이들");
        map5.put("gameYear","2000");
        map5.put("gameType","RPG");
        map5.put("companyCd","004_0005");
        map5.put("companyNm","크래프톤");

        ArrayList<Map<String,Object>> gameData = new ArrayList<Map<String,Object>>();
        gameData.add(map);
        gameData.add(map1);
        gameData.add(map2);
        gameData.add(map3);
        gameData.add(map4);
        gameData.add(map5);

        for (int i=0;i<gameData.size();i++){
            IndexRequest request = new IndexRequest("game_index")
                    .source("{\n" +
                            "\t\"gameCd\" : \""+gameData.get(i).get("gameCd")+"\",\n" +
                            "\t\"gameNm\" : \""+gameData.get(i).get("gameNm")+"\",\n" +
                            "\t\"gameYear\" : \""+gameData.get(i).get("gameYear")+"\",\n" +
                            "\t\"gameType\" : \""+gameData.get(i).get("gameType")+"\",\n" +
                            "\t\"gameCompany\": [\n" +
                            "\t\t{\n" +
                            "\t\t\t\"companyCd\": \""+gameData.get(i).get("companyCd")+"\"\n" +
                            "\t\t}, \n" +
                            "\t\t{\n" +
                            "\t\t\t\"companyNm\": \""+gameData.get(i).get("companyNm")+"\"\n" +
                            "\t\t}\n" +
                            "\t]\n" +
                            "}", XContentType.JSON);
            client.index(request, RequestOptions.DEFAULT);
        }
    }

    //Document id로 읽기 - GET /{index}/_doc/{id}
    public static GetResponse documentSearch(RestHighLevelClient client) throws IOException {
        GetRequest request = new GetRequest("game_index","hNRjY3kBo0VlJQ3DUUBo");
        return client.get(request,RequestOptions.DEFAULT);
    }

    //Document id로 수정하기 - POST /{index}/_doc/{id}/_update
    public static void documentUpdate(RestHighLevelClient client) throws IOException {
        Map<String,Object> bodyMap = new HashMap<String,Object>();
        bodyMap.put("gameYear","2002");
        UpdateRequest request = new UpdateRequest("game_index","hNRjY3kBo0VlJQ3DUUBo").doc(bodyMap);
        client.update(request,RequestOptions.DEFAULT);
    }
    
    //Document id로 삭제하기 - DELETE /{index}/_doc/{id}
    public static void documentDelete(RestHighLevelClient client) throws IOException {
        DeleteRequest request = new DeleteRequest("game_index","hNRjY3kBo0VlJQ3DUUBo");
        client.delete(request,RequestOptions.DEFAULT);
    }

    //Document 전체 읽기(Search) - POST/GET /{index}/_search
    public static SearchResponse allSearch(RestHighLevelClient client) throws IOException {
        SearchRequest searchRequest = new SearchRequest("game_index").source(new SearchSourceBuilder());
        return client.search(searchRequest,RequestOptions.DEFAULT);
    }

    //Document 조건 넣어 읽기1(Search) - POST/GET /{index}/_search
    public static SearchResponse oneDtailSearch(RestHighLevelClient client) throws IOException {

        // 검색 조건 셋팅
        SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
        sourceBuilder.query(QueryBuilders.termQuery("gameNm","검은사막")); // 조건 하나일때 사용가능
        sourceBuilder.from(0);
        sourceBuilder.size(5);

        // 검색할 인덱스 셋팅
        SearchRequest searchRequest = new SearchRequest("game_index");
        searchRequest.source(sourceBuilder);
        
        // 클라이언트에 요청 - search
        return client.search(searchRequest,RequestOptions.DEFAULT);
    }

    //Document 조건 넣어 읽기2(Search) - POST/GET /{index}/_search
    public static SearchResponse manyDtailSearch(RestHighLevelClient client) throws IOException {
        // 검색 조건 셋팅
        SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
        sourceBuilder.query(QueryBuilders.matchQuery("gameCompany.companyCd","002_0002")); // 컬럼안에 컬럼 조회 방법 ... 간신히 발견

        //QueryBuilders.matchQuery("gameNm","검은사막");
        //BoolQueryBuilder boolQuery = new BoolQueryBuilder(); // 다중 조건을 위해 필요한 bool 클래스 - and 조건
        //boolQuery.must(QueryBuilders.matchQuery("gameCompany.companyNm","넥슨"));
        //sourceBuilder.query(boolQuery);

        sourceBuilder.from(0);
        sourceBuilder.size(100);

        // 검색할 인덱스 셋팅
        SearchRequest searchRequest = new SearchRequest("game_index");
        searchRequest.source(sourceBuilder);
        SearchResponse response = client.search(searchRequest,RequestOptions.DEFAULT);
        SearchHits searchHits = response.getHits();
        TotalHits totalHits = searchHits.getTotalHits();

        // 클라이언트에 요청 - search
        return response;
    }
}