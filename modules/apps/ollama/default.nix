{ username, ... }: {
  services.ollama = {
    enable = true;
    # loadModels = [ "deepseek-r1" "gemma3" "qwen3" "llama4" "devstral" ];
  };
  #services.nextjs-ollama-llm-ui = { enable = true; };
  home-manager.users.${username} = { pkgs, ... }: {
    home.packages = with pkgs; [ alpaca ];
  };

}
