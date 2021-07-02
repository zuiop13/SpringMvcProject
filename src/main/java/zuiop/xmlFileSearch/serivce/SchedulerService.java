package zuiop.xmlFileSearch.serivce;

import zuiop.xmlFileSearch.vo.LocalApiVO;

import java.util.List;
import java.util.Map;

public interface SchedulerService {
	public abstract void apiMerge(LocalApiVO vo) throws Exception;
	public abstract List<Map<String,String>> localdataSelect(LocalApiVO vo) throws Exception;
}