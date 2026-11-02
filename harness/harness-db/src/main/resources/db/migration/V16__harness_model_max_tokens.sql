-- =====================================================================================
-- harness V16 :: the output budget belongs to the model
--
-- How many tokens a model may spend on one turn is a property of the model, not of the
-- agent. A reasoning model that writes a file thinks for 46 000 tokens before it acts; a
-- budget of 32 000 does not make it act sooner, it makes it think the same 32 000 tokens
-- again from the start, and the file never appears.
--
-- So the budget is configured with the model. Left empty, the client's own default applies.
-- =====================================================================================

SET NAMES utf8mb4;

ALTER TABLE `harness_model_config`
  ADD COLUMN `max_tokens` INT(11) DEFAULT NULL
    COMMENT '单轮输出预算（token）；空 = 用客户端默认。推理模型写文件需要给够';
