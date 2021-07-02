package zuiop.xmlFileSearch.controller;

import com.google.gson.Gson;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import zuiop.MainController;
import zuiop.RestApi.RestApiMain;
import zuiop.Util.Util;
import zuiop.System.SystemConstants;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import zuiop.xmlFileSearch.serivce.SchedulerService;
import zuiop.xmlFileSearch.vo.LocalApiVO;

import javax.annotation.Resource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.*;

import java.net.UnknownHostException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class XmlFileSearchController {

    @Resource(name="schedulerService")
    SchedulerService schedulerService;

    /* 컨트롤단 */
    @RequestMapping(value = "/search",method = RequestMethod.GET)
    public @ResponseBody
    String search(@RequestParam(value="select",required=false) String select
            ,ModelMap model) throws Exception {
        Gson gson = new Gson();
        return gson.toJson(selectKosisData(select));
    }

    @RequestMapping(value = "/localSearch",method = RequestMethod.GET)
    public @ResponseBody
    String localSearch(@RequestParam(value="gubun",required=false)  String gubun
            , @RequestParam(value="select",required=false) String select
            , ModelMap model) throws Exception {
        Gson gson = new Gson();
        if(!"".equals(Util.strNull(gubun))){
            return gson.toJson(localdataSelect(gubun,select));
        }else{
            return null;
        }
    }

    /* 데이터 이관 작업 01~06 */
    @RequestMapping(value = "/apiXmlinsert",method = RequestMethod.GET)
    public String dataInsert(ModelMap model) throws UnknownHostException {
        dataInsert();
        return "index";
    }

    @RequestMapping(value = "/apiUpdate",method = RequestMethod.GET)
    public String insertUpdate(ModelMap model) throws UnknownHostException {
        dataInsertUpdate();
        return "index";
    }



    /* 소스 단 */

    /* 동물병원 dataInsertAll */
    public void dataInsert() {
        String filePath = SystemConstants.XML_PATH01;
        File file = new File(filePath);
        if (file.exists()) {
            xmlLocaldataParsing(file);   /* xml parsing */
        }

        filePath = SystemConstants.XML_PATH02;
        file = new File(filePath);
        if (file.exists()) {
            xmlLocaldataParsing(file);   /* xml parsing */
        }

        filePath = SystemConstants.XML_PATH03;
        file = new File(filePath);
        if (file.exists()) {
            xmlLocaldataParsing(file);   /* xml parsing */
        }

        filePath = SystemConstants.XML_PATH04;
        file = new File(filePath);
        if (file.exists()) {
            xmlLocaldataParsing(file);   /* xml parsing */
        }

        filePath = SystemConstants.XML_PATH05;
        file = new File(filePath);
        if (file.exists()) {
            xmlLocaldataParsing(file);   /* xml parsing */
        }

        filePath = SystemConstants.XML_PATH06;
        file = new File(filePath);
        if (file.exists()) {
            xmlLocaldataParsing(file);   /* xml parsing */
        }
    }

    /* 팻샵 dataInsertUpdate */
    public void dataInsertUpdate() {
        /* api list - 팻샵 */
        int pageSize = 10000;
        String url = SystemConstants.LOCALDATA_DOMAIN + "?" + "authKey=" + SystemConstants.LOCALDATA_KEY+"&"+"pageSize="+pageSize;
        String xml = RestApiMain.getApiXmlCall(url);    /* api call */
        if (xml != null) {
            xmlLocaldataParsing(xml);     /* xml parsing */
        }
    }

    /* view 용 selectKosisData*/
    public List<Map<String,String>> selectKosisData(String select) {
        List<Map<String,String>> list = null;
        //* api list - 공공 데이터
        int rows = 1000000000;
        String url = SystemConstants.KOSIS_DOMAIN+"?"+"serviceKey="+SystemConstants.KOSIS_KEY+"&"+"numOfRows="+rows;
        String xml = RestApiMain.getApiXmlCall(url);
        if(xml != null){
            System.out.println(url);
            list = xmlKosisParsing(xml,select);
        }
        return list;
    }

    /* 로컬 데이터 통합 SELECT - LIST */
    public List<Map<String,String>> localdataSelect(String gubun,String select){
        List<Map<String,String>> listMap = new ArrayList<Map<String,String>>();
        try {
            LocalApiVO vo = new LocalApiVO();
            vo.setTrdStateGbn("01");   //사용가능
            vo.setOpnSvcId(gubun);     //구분
            vo.setSiteWhlAddr(select); //지역
            listMap = schedulerService.localdataSelect(vo);
        } catch (Exception e){
            e.printStackTrace();
        }
        return listMap;
    }

    /* xml parsing - file */
    private static void xmlLocaldataParsing(File file){
        try {
            /* db 접근 */
            Class.forName("org.postgresql.Driver");
            String url      = SystemConstants.DB_URL;
            String username = SystemConstants.DB_USER;
            String password = SystemConstants.DB_PW;
            Connection connection = DriverManager.getConnection(url,username,password);

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder documentBuilder = factory.newDocumentBuilder();
            Document document = documentBuilder.parse(file);
            /* */
            document.getDocumentElement().normalize();
            System.out.println("Root name: " + document.getDocumentElement().getNodeName());

            NodeList columnList = document.getElementsByTagName("columns");
            System.out.println("파싱할 columns 리스트 수 : "+ columnList.getLength());  // 파싱할 리스트 수

            NodeList rowList = document.getElementsByTagName("row");
            System.out.println("파싱할 row 리스트 수 : "+ rowList.getLength());  // 파싱할 리스트 수

            String rowNum;
            String mgtNo;
            String opnSvcNm;
            String opnSvcId;
            String bplcNm;
            String siteTel;
            String siteWhlAddr;
            String rdnWhlAddr;
            String rdnPostNo;
            String x;
            String y;
            String trdStateGbn;
            String trdStateNm;

            /* row List */
            for(int temp=0; temp < rowList.getLength(); temp++){
                Node nNode = rowList.item(temp);
                if(nNode.getNodeType() == Node.ELEMENT_NODE){
                    Map<String,String> map = new HashMap<String,String>();
                    Element eElement = (Element) nNode;
                    rowNum      = Util.strNull(getTagValue("rowNum", eElement)).replace("'","''").trim();
                    mgtNo       = Util.strNull(getTagValue("mgtNo", eElement)).replace("'","''").trim();
                    opnSvcNm    = Util.strNull(getTagValue("opnSvcNm", eElement)).replace("'","''").trim();
                    opnSvcId    = Util.strNull(getTagValue("opnSvcId", eElement)).replace("'","''").trim();
                    bplcNm      = Util.strNull(getTagValue("bplcNm", eElement)).replace("'","''").trim();
                    siteTel     = Util.strNull(getTagValue("siteTel", eElement)).replace("'","''").trim();
                    siteWhlAddr = Util.strNull(getTagValue("siteWhlAddr", eElement)).replace("'","''").trim();
                    rdnWhlAddr  = Util.strNull(getTagValue("rdnWhlAddr", eElement)).replace("'","''").trim();
                    rdnPostNo   = Util.strNull(getTagValue("rdnPostNo", eElement)).replace("'","''").trim();
                    x           = Util.strNull(getTagValue("x", eElement)).replace("'","''").trim();
                    y           = Util.strNull(getTagValue("y", eElement)).replace("'","''").trim();
                    trdStateGbn = Util.strNull(getTagValue("trdStateGbn", eElement)).replace("'","''").trim();
                    trdStateNm  = Util.strNull(getTagValue("trdStateNm", eElement)).replace("'","''").trim();

                    /* 비어있는 주소 교체*/
                    siteWhlAddr = siteWhlAddr == ""?rdnWhlAddr:siteWhlAddr;

                    // db insert data list
                    System.out.println("=====================================================================");
                    System.out.println("rowNum    : " + rowNum);
                    System.out.println("mgtNo     : " + mgtNo);
                    System.out.println("opnSvcNm  : " + opnSvcNm);
                    System.out.println("opnSvcId  : " + opnSvcId);

                    System.out.println("bplcNm    : " + bplcNm);
                    System.out.println("siteTel   : " + siteTel);

                    System.out.println("siteWhlAddr  : " + siteWhlAddr);
                    System.out.println("rdnWhlAddr   : " + rdnWhlAddr);
                    System.out.println("rdnPostNo    : " + rdnPostNo);

                    System.out.println("x  : " + x);
                    System.out.println("y  : " + y);

                    System.out.println("trdStateGbn  : " + trdStateGbn);
                    System.out.println("trdStateNm   : " + trdStateNm);

                    //insert 현재 테스트 중입니다.
                    String sql = "INSERT INTO t_animal_api(mgtno, opnsvcnm, opnsvcid , bplcnm, sitetel, sitewhladdr, rdnwhladdr, rdnpostno, x, y, trdstategbn, trdstatenm)"+ "VALUES('"+mgtNo+"','"+opnSvcNm+"','"+opnSvcId+"','"+bplcNm+"','"+siteTel+"','"+siteWhlAddr+"','"+rdnWhlAddr+"','"+rdnPostNo+"','"+x+"','"+y+"','"+trdStateGbn+"','"+trdStateNm+"')";
                    System.out.println(sql);
                    PreparedStatement statement = connection.prepareStatement(sql);
                    statement.execute();
                    System.out.println("=======================DB insert 성공=================================");
                    System.out.println("=====================================================================");
                }
            }
        }catch(ParserConfigurationException e){
            e.printStackTrace();
        } catch(IOException e){
            e.printStackTrace();
        } catch(SAXException e){
            e.printStackTrace();
        } catch (SQLException e){
            e.printStackTrace();
        } catch (ClassNotFoundException e){
            e.printStackTrace();
        }
        System.out.println();
    }

    /* xml parsing - api */
    private static void xmlLocaldataParsing(String xml){
        try {
            /* db 접근 */
            Class.forName("org.postgresql.Driver");
            String url      = SystemConstants.DB_URL;
            String username = SystemConstants.DB_USER;
            String password = SystemConstants.DB_PW;
            Connection connection = DriverManager.getConnection(url,username,password);

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder documentBuilder = factory.newDocumentBuilder();
            InputStream is =new ByteArrayInputStream(xml.getBytes());
            Document document = documentBuilder.parse(is);

            /* */
            document.getDocumentElement().normalize();
            System.out.println("Root name: " + document.getDocumentElement().getNodeName());

            NodeList columnList = document.getElementsByTagName("columns");
            System.out.println("파싱할 columns 리스트 수 : "+ columnList.getLength());  // 파싱할 리스트 수

            NodeList rowList = document.getElementsByTagName("row");
            System.out.println("파싱할 row 리스트 수 : "+ rowList.getLength());  // 파싱할 리스트 수

            String rowNum;
            String mgtNo;
            String opnSvcNm;
            String opnSvcId;
            String bplcNm;
            String siteTel;
            String siteWhlAddr;
            String rdnWhlAddr;
            String rdnPostNo;
            String x;
            String y;
            String trdStateGbn;
            String trdStateNm;

            /* row List */
            for(int temp=0; temp < rowList.getLength(); temp++){
                Node nNode = rowList.item(temp);
                if(nNode.getNodeType() == Node.ELEMENT_NODE){
                    Map<String,String> map = new HashMap<String,String>();
                    Element eElement = (Element) nNode;
                    rowNum      = Util.strNull(getTagValue("rowNum", eElement)).replace("'","''").trim();
                    mgtNo       = Util.strNull(getTagValue("mgtNo", eElement)).replace("'","''").trim();
                    opnSvcNm    = Util.strNull(getTagValue("opnSvcNm", eElement)).replace("'","''").trim();
                    opnSvcId    = Util.strNull(getTagValue("opnSvcId", eElement)).replace("'","''").trim();
                    bplcNm      = Util.strNull(getTagValue("bplcNm", eElement)).replace("'","''").trim();
                    siteTel     = Util.strNull(getTagValue("siteTel", eElement)).replace("'","''").trim();
                    siteWhlAddr = Util.strNull(getTagValue("siteWhlAddr", eElement)).replace("'","''").trim();
                    rdnWhlAddr  = Util.strNull(getTagValue("rdnWhlAddr", eElement)).replace("'","''").trim();
                    rdnPostNo   = Util.strNull(getTagValue("rdnPostNo", eElement)).replace("'","''").trim();
                    x           = Util.strNull(getTagValue("x", eElement)).replace("'","''").trim();
                    y           = Util.strNull(getTagValue("y", eElement)).replace("'","''").trim();
                    trdStateGbn = Util.strNull(getTagValue("trdStateGbn", eElement)).replace("'","''").trim();
                    trdStateNm  = Util.strNull(getTagValue("trdStateNm", eElement)).replace("'","''").trim();

                    /* 비어있는 주소 교체*/
                    siteWhlAddr = siteWhlAddr == ""?rdnWhlAddr:siteWhlAddr;

                    // db insert data list
                    System.out.println("=====================================================================");
                    System.out.println("rowNum    : " + rowNum);
                    System.out.println("mgtNo     : " + mgtNo);
                    System.out.println("opnSvcNm  : " + opnSvcNm);
                    System.out.println("opnSvcId  : " + opnSvcId);

                    System.out.println("bplcNm    : " + bplcNm);
                    System.out.println("siteTel   : " + siteTel);

                    System.out.println("siteWhlAddr  : " + siteWhlAddr);
                    System.out.println("rdnWhlAddr   : " + rdnWhlAddr);
                    System.out.println("rdnPostNo    : " + rdnPostNo);

                    System.out.println("x  : " + x);
                    System.out.println("y  : " + y);

                    System.out.println("trdStateGbn  : " + trdStateGbn);
                    System.out.println("trdStateNm   : " + trdStateNm);

                    if ("02_03_01_P".equals(opnSvcId) || "02_03_02_P".equals(opnSvcId) || "02_03_03_P".equals(opnSvcId) || "02_03_04_P".equals(opnSvcId) || "02_03_05_P".equals(opnSvcId) || "02_03_06_P".equals(opnSvcId)) {
                        //insert 현재 테스트 중입니다.
                        String sql = "WITH UPSERT AS(\n" +
                                "\tUPDATE T_ANIMAL_API\n" +
                                "\t   SET opnSvcNm    = '" + opnSvcNm + "'\n" +
                                "\t\t , opnSvcId      = '" + opnSvcId + "'\n" +
                                "\t\t , bplcNm\t      = '" + bplcNm + "'\n" +
                                "\t\t , siteTel\t     = '" + siteTel + "'\n" +
                                "\t\t , siteWhlAddr   = '" + siteWhlAddr + "'\n" +
                                "\t\t , rdnWhlAddr    = '" + rdnWhlAddr + "'\n" +
                                "\t\t , rdnPostNo     = '" + rdnPostNo + "'\n" +
                                "\t\t , x\t\t         = '" + x + "'\n" +
                                "\t\t , y \t\t        = '" + y + "'\n" +
                                "\t\t , trdStateGbn   = '" + trdStateGbn + "'\n" +
                                "\t\t , trdStateNm    = '" + trdStateNm + "'\n" +
                                "\t WHERE mgtNo       = '" + mgtNo + "' RETURNING *\n" +
                                ")\n" +
                                "INSERT\n" +
                                "  INTO T_ANIMAL_API (\n" +
                                "\t   mgtNo\n" +
                                "\t , opnSvcNm\n" +
                                "\t , opnSvcId\n" +
                                "\t , bplcNm\n" +
                                "\t , siteTel\n" +
                                "\t , siteWhlAddr\n" +
                                "\t , rdnWhlAddr\n" +
                                "\t , rdnPostNo\n" +
                                "\t , x\n" +
                                "\t , y \n" +
                                "\t , trdStateGbn\n" +
                                "\t , trdStateNm\n" +
                                ")\n" +
                                "SELECT '" + mgtNo + "'\n" +
                                "     , '" + opnSvcNm + "'\n" +
                                "     , '" + opnSvcId + "'\n" +
                                "     , '" + bplcNm + "'\n" +
                                "     , '" + siteTel + "'\n" +
                                "     , '" + siteWhlAddr + "'\n" +
                                "     , '" + rdnWhlAddr + "'\n" +
                                "     , '" + rdnPostNo + "'\n" +
                                "     , '" + x + "'\n" +
                                "     , '" + y + "'\n" +
                                "     , '" + trdStateGbn + "'\n" +
                                "     , '" + trdStateNm + "'\n" +
                                " WHERE NOT EXISTS ( SELECT * FROM UPSERT )";
                        System.out.println(sql);
                        PreparedStatement statement = connection.prepareStatement(sql);
                        statement.execute();
                        System.out.println("=======================DB insert/update 성공=================================");
                        System.out.println("=====================================================================");
                    }
                }
            }
        }catch(ParserConfigurationException e){
            e.printStackTrace();
        } catch(IOException e){
            e.printStackTrace();
        } catch(SAXException e){
            e.printStackTrace();
        }catch (SQLException e){
            e.printStackTrace();
        }catch (ClassNotFoundException e){
            e.printStackTrace();
        }
        System.out.println();
    }


    /* Kosis xml parsing - xml */
    public static List<Map<String,String>> xmlKosisParsing(String xml,String select){
        List<Map<String,String>> listMap = new ArrayList<Map<String,String>>();
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder documentBuilder = factory.newDocumentBuilder();
            InputStream is = new ByteArrayInputStream(xml.getBytes());
            Document document = documentBuilder.parse(is);
            /* */
            document.getDocumentElement().normalize();
            System.out.println("Root name: " + document.getDocumentElement().getNodeName());

            NodeList rowList = document.getElementsByTagName("item");
            System.out.println("파싱할 row 리스트 수 : "+ rowList.getLength());  // 파싱할 리스트 수

            String careNm;
            String careTel;
            String careAddr;
            String divisionNm;
            String lat;
            String lng;
            String weekOprStime;
            String weekOprEtime;
            String saveTrgtAnimal;
            String dsignationDate;
            String dataStdDt;

            /* row List */
            for(int temp=0; temp < rowList.getLength(); temp++){
                Node nNode = rowList.item(temp);
                if(nNode.getNodeType() == Node.ELEMENT_NODE){
                    Element eElement = (Element) nNode;
                    Map<String,String> map = new HashMap<String,String>();
                    careNm          = Util.strNull(getTagValue("careNm", eElement)).replace("'","''").trim();
                    careTel         = Util.strNull(getTagValue("careTel", eElement)).replace("'","''").trim();
                    careAddr        = Util.strNull(getTagValue("careAddr", eElement)).replace("'","''").trim();
                    divisionNm      = Util.strNull(getTagValue("divisionNm", eElement)).replace("'","''").trim();
                    lat             = Util.strNull(getTagValue("lat", eElement)).replace("'","''").trim();
                    lng             = Util.strNull(getTagValue("lng", eElement)).replace("'","''").trim();
                    weekOprStime    = Util.strNull(getTagValue("weekOprStime", eElement)).replace("'","''").trim();
                    weekOprEtime    = Util.strNull(getTagValue("weekOprEtime", eElement)).replace("'","''").trim();
                    saveTrgtAnimal  = Util.strNull(getTagValue("saveTrgtAnimal", eElement)).replace("'","''").trim();
                    dsignationDate  = Util.strNull(getTagValue("dsignationDate", eElement)).replace("'","''").trim();
                    dataStdDt       = Util.strNull(getTagValue("dataStdDt", eElement)).replace("'","''").trim();

                    /* 중복 주소는 데이터에 넣지 않는다. - 추후 결정하기 */
                    int cnt = 0;
                    for(int i=0;i < listMap.size();i++){
                        if(Util.strNull(listMap.get(i).get("careAddr")).equals(careAddr)){
                            cnt++;
                        }
                    }

                    if(cnt == 0) {
                        if(careAddr.indexOf(select) > -1) {  /* 주소 검색해서 찾기 */
                            // db insert data list
                            System.out.println("=============================================================================");
                            System.out.println("careNm      : " + careNm);
                            System.out.println("careTel     : " + careTel);
                            System.out.println("careAddr    : " + careAddr);
                            System.out.println("divisionNm  : " + divisionNm);
                            System.out.println("lat   : " + lat);
                            System.out.println("lng   : " + lng);
                            System.out.println("weekOprStime    : " + weekOprStime);
                            System.out.println("weekOprEtime    : " + weekOprEtime);
                            System.out.println("saveTrgtAnimal  : " + saveTrgtAnimal);
                            System.out.println("dsignationDate  : " + dsignationDate);
                            System.out.println("dataStdDt       : " + dataStdDt);
                            System.out.println("=======================DB insert/update 성공=================================");
                            System.out.println("============================================================================");
                            map.put("careNm", careNm);
                            map.put("careTel", careTel);
                            map.put("careAddr", careAddr);
                            map.put("divisionNm", divisionNm);
                            map.put("weekOprStime", weekOprStime);
                            map.put("weekOprEtime", weekOprEtime);
                            map.put("lat", lat);
                            map.put("lng", lng);
                            map.put("saveTrgtAnimal", saveTrgtAnimal);
                            map.put("dsignationDate", dsignationDate);
                            map.put("dataStdDt", dataStdDt);
                            listMap.add(map);
                        }
                    }
                }
            }
        }catch(ParserConfigurationException e){
            e.printStackTrace();
        } catch(IOException e){
            e.printStackTrace();
        } catch(SAXException e){
            e.printStackTrace();
        }
        System.out.println();
        return listMap;
    }

    /* tagValue */
    private static String getTagValue(String tag, Element eElement){
        NodeList nlList;
        try {
             nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
             Node nValue = (Node) nlList.item(0);
             if( nValue == null ) {
                 return null;
             }else{
                 return nValue.getNodeValue();
             }
        }catch (NullPointerException e){
            return null;
        }
    }
}