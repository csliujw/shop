package org.shop.service;

import com.google.gson.Gson;
import org.shop.dao.DivisionMapper;
import org.shop.pojo.DeleteVO;
import org.shop.pojo.Division;
import org.shop.utils.JSONData;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
@Service("divisionServiceImpl")
@Transactional
public class DivisionServiceImpl implements IBaseService<Division> {

    @Autowired
    private DivisionMapper divisionMapper;

    /**
     * 查询所有信息
     * @return
     */
    @Override
    public List<Division> selectAllDetail(){
        List<Division> list = divisionMapper.selectAllDetail();
        return list;
    }
    /**
     * @param division
     * @return 新增结果
     */
    @Override
    public boolean add(Division division) {
        boolean result = divisionMapper.orExit(division);
        if (!result) {
            division.setDivisionId(UUID.randomUUID().toString());
            boolean add = divisionMapper.addDivision(division);
            return add;
        }
        return false;
    }

    /**
     * @param division
     * @return 更新结果
     */
    @Override
    public boolean update(Division division) {
        boolean result = divisionMapper.updateDivision(division);
        return result;
    }

    /**
     * @param division
     * @return 删除结果
     */
    @Override
    public boolean delete(Division division) {
        boolean result = divisionMapper.deleteDivision(division);
        return result;
    }


    /**
     * @param vo
     * @return 批量操作全部成功返回true 否返回false
     */
    @Override
    public boolean deleteBatch(DeleteVO vo) {
        int result = divisionMapper.deleteBatchDivision(vo);
        if (result == vo.getIds().length) {
            return true;
        }
        return false;
    }

    /**
     * @param division
     * @return 条件查询所有数据总和
     */
    @Override
    public long selectAll(Division division) {
        long result = divisionMapper.selectAllDivision(division);
        return result;
    }


    /**
     * @param page
     * @return 条件分页查询结果
     */
    @Override
    public String selectAllPageCondition(Page<Division> page) {
        try {
            int start = 0;
            start = (Integer.parseInt(page.getPage()) - 1) * Integer.parseInt(page.getLimit());
            page.setStart(start + "");
            List<Division> divisions = divisionMapper.selectAllPageConditionDivision(page);
            long count = divisionMapper.selectAllDivision(page.getCondition());
            return new Gson().toJson(new JSONData<Division>(count + "", divisions));
        } catch (Exception e) {
            return new Gson().toJson(new JSONData<Division>("0", null));
        }
    }

    /**
     * @param division
     * @return 查询该xx的具体信息
     */
    @Override
    public String selectSingle(Division division) {
        return null;
    }

}
