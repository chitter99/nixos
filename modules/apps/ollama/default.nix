{ ... }: {
  services.ollama = {
    enable = true;
    loadModels = [ "deepseek-r1" "gemma3" "qwen3" "llama4" "devstral" ];
  };
}
