package zuiop.xmlFileSearch.serivce;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import zuiop.xmlFileSearch.vo.LocalApiVO;

import java.util.List;
import java.util.Map;

@Repository
public class SchedulerDao {
    @Autowired
    private SqlSessionTemplate sqlSession;

    public void apiMerge(LocalApiVO vo){

    }

    public List<Map<String, String>> localdataSelect(LocalApiVO vo) {
        return sqlSession.selectList("localData.select",vo);
    }
}
