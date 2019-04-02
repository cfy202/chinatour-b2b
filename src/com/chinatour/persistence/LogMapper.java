package com.chinatour.persistence;

import com.chinatour.entity.Log;
import org.springframework.stereotype.Repository;

/**
 * Dao - 日志
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Repository
public interface LogMapper extends BaseMapper<Log, Long> {

    /**
     * 删除所有日志
     */
    void removeAll();

}