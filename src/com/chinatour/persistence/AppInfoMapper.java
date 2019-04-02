package com.chinatour.persistence;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.AppInfo;

@Repository
public interface AppInfoMapper extends BaseMapper<AppInfo, String> {

}
