package zuiop.Scheduling;

import org.springframework.stereotype.Component;

@Component("apiScheduling")
public class ApiScheduling {
    /**
     * LocalData api를 호출하여 데이터를 최신화 시킨다.
     * 새벽 1시에 실행한다.
     * egov-com-servlet.xml에 설정되어 있음
     * @throws Exception
     */
    public void localDataInsertUpdate() {
        System.out.println("스케듈러 테스트 입니다.");
    }
}
