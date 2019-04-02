/*package com.chinatour.webService.impl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.Company;
import com.chinatour.entity.CompanyRequestTokenSecret;
import com.chinatour.persistence.AppInfoMapper;
import com.chinatour.persistence.CompanyMapper;
import com.chinatour.webService.OAuthInfoProvider;
import com.intuit.ia.exception.OAuthException;
@Service("oAuthInfoProviderImpl")
public class OAuthInfoProviderImpl implements OAuthInfoProvider {
	@Autowired
	private AppInfoMapper appInfoMapper;
	@Autowired
    private CompanyMapper companyMapper;
    
	
	public String getAppToken() {
		return appInfoMapper.findAll().get(0).getAppToken();
	}

	@Override
	public String getConsumerKey() {
		return appInfoMapper.findAll().get(0).getConsumerKey();
	}

	@Override
	public String getConsumerSecret() {
		return appInfoMapper.findAll().get(0).getConsumerSecret();
	}

	@Override
	public void setRequestTokenValuesForCompany(String companyId,
			String requestToken, String requestTokenSecret) {
		Company company = companyMapper.findById(companyId);
		if(company==null){
			company = new Company();
			company.setId(companyId);
			company.setRequestToken(requestToken);
			company.setRequestTokenSecret(requestTokenSecret);
	        companyMapper.save(company);
		}else{
			company.setRequestToken(requestToken);
			company.setRequestTokenSecret(requestTokenSecret);
			companyMapper.update(company);
		}
	}

	@Override
	public CompanyRequestTokenSecret getCompanyRequestTokenSecret(
			String requestToken) {
		final Company company = companyMapper.findByRequestToken(requestToken);

        if (company == null) {
            try {
				throw new OAuthException("Could not find a company with an request token of " + requestToken);
			} catch (OAuthException e) {
				e.printStackTrace();
			}
        }

        return new CompanyRequestTokenSecret("" + company.getId(), company.getRequestTokenSecret());
	}

	@Override
	public void setAccessTokenForCompany(String companyId, String realmId,
			String accessTokenValues, String accessTokenSecret) {
		Company company = companyMapper.findById(companyId);
		if(company==null){
			try {
				throw new OAuthException("Could not find a company with an id of " + companyId);
			} catch (OAuthException e) {
				e.printStackTrace();
			}
		}else{
			company.setQboId(realmId);
	        company.setAccessToken(accessTokenValues);
	        company.setAccessTokenSecret(accessTokenSecret);
	        company.setConnectedToQbo(1);
	        companyMapper.update(company);
		}
	}

	


}
*/