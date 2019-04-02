package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(callSuper = false)
public class Company  extends BaseUuidEntity {
	@JsonProperty
	private String name;
	@JsonProperty
	private Integer connectedToQbo;
	@JsonProperty
	private Integer employeesSynced;
	@JsonProperty
	private Integer customersSynced;
	@JsonProperty
	private Integer serviceItemsSynced;
	@JsonProperty
	private String qboId;
	@JsonProperty
	private String requestToken;
	@JsonProperty
	private String requestTokenSecret;
	@JsonProperty
	private String accessToken;
	@JsonProperty
	private String accessTokenSecret;


    public Company() {

    }

    public Company(String qdoId, String accessToken, String accessTokenSecret) {
        this.qboId = qdoId;
        this.accessToken = accessToken;
        this.accessTokenSecret = accessTokenSecret;
        this.connectedToQbo = 1;
    }
}
