package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyRequestTokenSecret {
	@JsonProperty
    private final String appCompanyId;
	@JsonProperty
	private final String requestTokenSecret;

    public CompanyRequestTokenSecret(String appCompanyId, String requestTokenSecret) {
        this.appCompanyId = appCompanyId;
        this.requestTokenSecret = requestTokenSecret;
    }

    public String getAppCompanyId() {
        return appCompanyId;
    }

    public String getRequestTokenSecret() {
        return requestTokenSecret;
    }
}
