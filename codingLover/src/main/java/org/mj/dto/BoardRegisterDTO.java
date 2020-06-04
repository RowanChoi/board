package org.mj.dto;

import org.mj.domain.BoardVO;

import lombok.Data;

@Data
public class BoardRegisterDTO {
	private String title;
	private String content;
	private String writer;
	private String category;

	public BoardVO getBoard() {
		BoardVO board = new BoardVO();
		board.setContent(content);
		board.setTitle(title);
		board.setWriter(writer);
		board.setCategory(category);
		return board;
	}
}
