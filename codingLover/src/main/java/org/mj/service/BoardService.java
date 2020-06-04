package org.mj.service;

import java.util.List;

import org.mj.domain.BoardVO;
import org.mj.dto.BoardDTO;
import org.mj.dto.BoardFileDTO;
import org.mj.dto.BoardListDTO;

public interface BoardService {

	public List<BoardListDTO> getList();

	public int register(BoardVO board, List<BoardFileDTO> files);

	public BoardDTO get(int bno);

	public boolean modify(BoardVO board);

}
