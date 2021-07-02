package zuiop.xmlFileSearch.serivce;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import zuiop.xmlFileSearch.vo.LocalApiVO;

import java.util.List;
import java.util.Map;

@Service("schedulerService")
public class SchedulerServiceImpl implements SchedulerService {

	@Autowired
	SchedulerDao schedulerDao;

	@Override
	public void apiMerge(LocalApiVO vo) throws Exception {
		schedulerDao.apiMerge(vo);
	}

	@Override
	public List<Map<String, String>> localdataSelect(LocalApiVO vo) throws Exception {
		return schedulerDao.localdataSelect(vo);
	}
}
