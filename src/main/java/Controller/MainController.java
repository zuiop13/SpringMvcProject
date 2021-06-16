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
    String search(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        Gson gson = new Gson();
        return gson.toJson(xml.selectKosisData());
    }

    @RequestMapping(value = "/localSearch",method = RequestMethod.GET)
    public @ResponseBody
    String localSearch(@RequestParam(value="gubun",required=false) String gubun, ModelMap model) throws UnknownHostException {
        System.out.println("test"+gubun);
        XmlFileSearch xml = new XmlFileSearch();
        Gson gson = new Gson();
        if(!"".equals(Util.strNull(gubun))){
            return gson.toJson(xml.localdataSelect(gubun));
        }else{
            return null;
        }
    }


    @RequestMapping(value = "/dataInsert_02_03_01_P",method = RequestMethod.GET)
    public String dataInsert_02_03_01_P(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        xml.dataInsert_02_03_01_P();
        return "index";
    }

    @RequestMapping(value = "/dataInsert_02_03_02_P",method = RequestMethod.GET)
    public String dataInsert_02_03_02_P(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        xml.dataInsert_02_03_02_P();
        return "index";
    }

    @RequestMapping(value = "/dataInsert_02_03_03_P",method = RequestMethod.GET)
    public String dataInsert_02_03_03_P(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        xml.dataInsert_02_03_03_P();
        return "index";
    }

    @RequestMapping(value = "/dataInsert_02_03_04_P",method = RequestMethod.GET)
    public String dataInsert_02_03_04_P(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        xml.dataInsert_02_03_04_P();
        return "index";
    }

    @RequestMapping(value = "/dataInsert_02_03_05_P",method = RequestMethod.GET)
    public String dataInsert_02_03_05_P(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        xml.dataInsert_02_03_05_P();
        return "index";
    }

    @RequestMapping(value = "/dataInsert_02_03_06_P",method = RequestMethod.GET)
    public String dataInsert_02_03_06_P(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        xml.dataInsert_02_03_06_P();
        return "index";
    }


    @RequestMapping(value = "/insertUpdate",method = RequestMethod.GET)
    public String insertUpdate(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        xml.dataInsertUpdate();
        return "index";
    }

}
