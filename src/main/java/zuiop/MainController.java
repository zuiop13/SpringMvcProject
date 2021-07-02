package zuiop;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import java.net.UnknownHostException;
import java.time.LocalDate;

@Controller
public class MainController {
    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String test(ModelMap model) throws UnknownHostException {
        return "index";
    }
}
