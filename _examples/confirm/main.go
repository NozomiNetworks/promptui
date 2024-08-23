package main

import (
	"fmt"

	"github.com/NozomiNetworks/promptui"
)

func main() {
	prompt := promptui.Prompt{
		Label:     "Delete Resource",
		IsConfirm: true,
		Default:   "n",
	}

	result, err := prompt.Run()

	if err != nil {
		fmt.Printf("Prompt failed %v\n", err)
		return
	}

	fmt.Printf("You choose %q\n", result)
}
