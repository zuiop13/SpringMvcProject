package Controller;

import Controller.xmlFileSearch.XmlFileSearch;
import com.google.gson.Gson;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.UnknownHostException;


@Controller
public class MainController {

    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String test(ModelMap model) throws UnknownHostException {
        return "index";
    }

    @RequestMapping(value = "/test01",method = RequestMethod.GET)
    public @ResponseBody
    String test01(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        Gson gson = new Gson();
        return gson.toJson(xml.selectKosisData());
    }

    @RequestMapping(value = "/test02",method = RequestMethod.GET)
    public @ResponseBody
    String test02(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        Gson gson = new Gson();
        return gson.toJson(xml.localdataSelect());
    }

    @RequestMapping(value = "/test03",method = RequestMethod.GET)
    public @ResponseBody
    String test03(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        model.addAttribute("Data",xml.selectKosisData());
        return "index";
    }

    @RequestMapping(value = "/insertAll",method = RequestMethod.GET)
    public String insertAll(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        xml.dataInsertAll();
        return "index";
    }

    @RequestMapping(value = "/insertUpdate",method = RequestMethod.GET)
    public String insertUpdate(ModelMap model) throws UnknownHostException {
        XmlFileSearch xml = new XmlFileSearch();
        xml.dataInsertUpdate();
        return "index";
    }

}
