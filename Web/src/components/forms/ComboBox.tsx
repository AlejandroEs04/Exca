import { ChangeEvent, KeyboardEvent, useEffect, useState } from "react";

export type OptionCB = {
    id: string | number;
    label: string;
};

type ComboBoxProps = {
    name: string;
    value: string | number;
    options: OptionCB[];
    placeholder?: string;
    label?: string;
    disabled?: boolean;
    isHorizontal?: boolean
    className?: string;
    onSelect: (selectedId: string | number, name: string) => void;
    onCreate: (newItemLabel: string, name: string) => void;
};

export default function ComboBox({
    name,
    value,
    options,
    placeholder = "",
    label = "",
    disabled = false,
    className = "",
    isHorizontal = false,
    onSelect,
    onCreate,
}: ComboBoxProps) {
    const [inputValue, setInputValue] = useState("");
    const [showOptions, setShowOptions] = useState(false);
    const [filteredOptions, setFilteredOptions] = useState<OptionCB[]>(options);

    useEffect(() => {
        const selectedOption = options.find((opt) => opt.id === value);
        if (selectedOption) {
        setInputValue(selectedOption.label);
        }
    }, [value, options]);

    useEffect(() => {
        if (inputValue === "") {
        setFilteredOptions(options);
        } else {
        setFilteredOptions(
            options.filter((option) =>
            option.label.toLowerCase().includes(inputValue.toLowerCase())
            )
        );
        }
    }, [inputValue, options]);

    const handleInputChange = (e: ChangeEvent<HTMLInputElement>) => {
        setInputValue(e.target.value);
        setShowOptions(true);
    };

    const handleSelectOption = (option: OptionCB) => {
        setInputValue(option.label);
        onSelect(option.id, name);
        setShowOptions(false);
    };

    const handleKeyDown = (e: KeyboardEvent<HTMLInputElement>) => {
        if (e.key === "Enter" || e.key === 'Tab') {
            e.preventDefault();
            // Si hay opciones filtradas, seleccionar la primera
            if (filteredOptions.length > 0) {
                handleSelectOption(filteredOptions[0]);
            } else {
                // Si no hay opciones, crear un nuevo ítem
                onCreate(inputValue.trim(), name);
                setInputValue("");
            }
        }
    };

    const handleBlur = () => {
        setTimeout(() => setShowOptions(false), 200);
    };

    return (
        <div className={`combo-box ${className} ${isHorizontal && 'horizontal g-2'}`}>
            {label && <label htmlFor={name}>{label}</label>}
            
            <input
                type="text"
                name={name}
                value={inputValue}
                placeholder={placeholder}
                disabled={disabled}
                onChange={handleInputChange}
                onKeyDown={handleKeyDown}
                onFocus={() => setShowOptions(true)}
                onBlur={handleBlur}
                autoComplete="off"
            />

            {showOptions && filteredOptions.length > 0 && (
                <ul className="combo-box-options">
                    {filteredOptions.map((option) => (
                        <li
                        key={option.id}
                        onMouseDown={() => handleSelectOption(option)}
                        className={value === option.id ? "selected" : ""}
                        >
                        {option.label}
                        </li>
                    ))}
                </ul>
            )}

            {showOptions && filteredOptions.length === 0 && inputValue && (
                <div className="combo-box-create">
                    <span>Enter para crear nuevo: "{inputValue}"</span>
                </div>
            )}
        </div>
    );
}