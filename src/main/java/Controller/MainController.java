package Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


@Controller
public class MainController {
    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String test(){
        System.out.printf("1111111111111");
        return "index";
    }

    @RequestMapping(value = "/create",method = RequestMethod.GET)
    public String create() throws ClassNotFoundException {
        Class.forName("org.postgresql.Driver");
        String url = "jdbc:postgresql://10.100.101.118:5432/springdata";
        String username = "zuiop13";
        String password = "pass";

        try(Connection connection = DriverManager.getConnection(url,username,password)) {
            System.out.println("====================================");
            System.out.println("Test connection created "+connection);

            //create
            String sql = "create table account (id int,username varchar(255),password varchar(255));";

            try(PreparedStatement statement = connection.prepareStatement(sql)){
                statement.execute();
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return "index";
    }

    @RequestMapping(value = "/insert",method = RequestMethod.GET)
    public String insert() throws ClassNotFoundException {
        Class.forName("org.postgresql.Driver");
        String url = "jdbc:postgresql://10.100.101.118:5432/springdata";
        String username = "zuiop13";
        String password = "pass";
        String gourl    = "err";

        try(Connection connection = DriverManager.getConnection(url,username,password)) {
            System.out.println("====================================");
            System.out.println("Test connection created "+connection);

            //insert 현재 테스트 중입니다.
            String sql = "insert into account VALUES(1,'zuiop13','pass','5000');";
            gourl = "insert";
            try(PreparedStatement statement = connection.prepareStatement(sql)){
                statement.execute();
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return gourl;
    }
}
