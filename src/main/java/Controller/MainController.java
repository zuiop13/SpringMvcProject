package Controller;

import Controller.Util.Util;
import Controller.xmlFileSearch.XmlFileSearch;
import com.google.gson.Gson;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.UnknownHostException;


@Controller
public class MainController {

    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String test(ModelMap model) throws UnknownHostException {
        return "index";
    }

    @RequestMapping(value = "/search",method = RequestMethod.GET)
    public @ResponseBody
    String search(@RequestParam(value="select",required=false) String select
                 ,ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        Gson gson = new Gson();
        return gson.toJson(xml.selectKosisData(select));
    }

    @RequestMapping(value = "/localSearch",method = RequestMethod.GET)
    public @ResponseBody
    String localSearch(@RequestParam(value="gubun",required=false)  String gubun
                     , @RequestParam(value="select",required=false) String select
                     , ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        Gson gson = new Gson();
        if(!"".equals(Util.strNull(gubun))){
            return gson.toJson(xml.localdataSelect(gubun,select));
        }else{
            return null;
        }
    }

    /* 데이터 이관 작업 01~06 */
    @RequestMapping(value = "/apiXmlinsert",method = RequestMethod.GET)
    public String dataInsert(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        xml.dataInsert();
        return "index";
    }

    @RequestMapping(value = "/apiUpdate",method = RequestMethod.GET)
    public String insertUpdate(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        xml.dataInsertUpdate();
        return "index";
    }

}
