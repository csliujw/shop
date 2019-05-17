package org.shop.service;

import com.google.gson.Gson;
import org.shop.dao.SubdivisionMapper;
import org.shop.pojo.DeleteVO;
import org.shop.pojo.Subdivision;
import org.shop.utils.JSONData;
import org.shop.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class SubdivisionServiceImpl implements IBaseService<Subdivision>{

    @Autowired
    private SubdivisionMapper subdivisionMapper;
    @Override
    public boolean add(Subdivision subdivision) {
        subdivision.setSubdivisionId(UUID.randomUUID().toString());
        boolean result = subdivisionMapper.addSubdivision(subdivision);
        return result;
    }

    @Override
    public boolean update(Subdivision subdivision) {
        boolean result = subdivisionMapper.updateSubdivision(subdivision);
        return result;
    }

    @Override
    public boolean delete(Subdivision subdivision) {
        boolean result = subdivisionMapper.deleteSubdivision(subdivision);
        return result;
    }

    @Override
    public boolean deleteBatch(DeleteVO vo) {
        int count = subdivisionMapper.deleteBatchSubdivision(vo);
        if(count==vo.getIds().length)
            return true;
        return false;
    }

    @Override
    public long selectAll(Subdivision subdivision) {
        long result = subdivisionMapper.selectAllSubdivision(subdivision);
        return result;
    }

    @Override
    public String selectAllPageCondition(Page<Subdivision> page) {
        try {
            int start = 0;
            start = (Integer.parseInt(page.getPage()) - 1) * Integer.parseInt(page.getLimit());
            page.setStart(start + "");
            List<Subdivision> subdivision = subdivisionMapper.selectAllPageConditionSubdivision(page);
            long count = subdivisionMapper.selectAllSubdivision(page.getCondition());
            return new Gson().toJson(new JSONData<Subdivision>(count + "", subdivision));
        } catch (Exception e) {
            return new Gson().toJson(new JSONData<Subdivision>("0", null));
        }
    }

    @Override
    public String selectSingle(Subdivision subdivision) {
        return null;
    }

    @Override
    public List<Subdivision> selectAllDetail() {
        return null;
    }
}
