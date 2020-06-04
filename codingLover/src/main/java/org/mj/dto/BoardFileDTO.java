package org.mj.dto;

import lombok.Data;

@Data
public class BoardFileDTO {
	private int fileNo;
	private int bno;
	private String fileName;
	private String filePath;
	private long fileSize;
	private String originFileName;
}
