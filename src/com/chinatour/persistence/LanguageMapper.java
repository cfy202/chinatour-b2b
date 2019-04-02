package com.chinatour.persistence;


import org.springframework.stereotype.Repository;

import com.chinatour.entity.Language;

/**
 * Dao  语种
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-9-19 下午1:23:22
 * @revision  3.0
 */

@Repository
public interface LanguageMapper extends BaseMapper<Language, String> {
}