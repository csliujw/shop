package org.shop.service;

import java.util.List;

public interface IBaseExtend<T> extends IBaseService<T> {
    /**
     * @param orDelete true 查询被删除的  false 查询未被删除的
     * @return
     */
    List<T> selectAllInfo(boolean orDelete);
}
