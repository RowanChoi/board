package org.mj.mapper;

import java.util.List;

import org.mj.domain.BoardFileVO;
import org.mj.domain.BoardVO;
import org.mj.dto.BoardListDTO;
import org.mj.dto.BoardFileDTO;
import org.mj.dto.BoardDTO;

public interface BoardMapper {

	public List<BoardListDTO> getList();

	public Integer insertSelectKey(BoardVO board);

	public void insertFile(BoardFileDTO boardFileDTO);

	public int updateHit(int bno);

	public BoardDTO read(int bno);

	public List<BoardFileDTO> readFile(int bno);

	public int update(BoardVO board);

}
