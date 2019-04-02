package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Company;
@Repository
public interface CompanyMapper extends BaseMapper<Company,String>{
	List<Company> findByQboId(String qboId);
	 Company findByRequestToken(String requestToken);
}
