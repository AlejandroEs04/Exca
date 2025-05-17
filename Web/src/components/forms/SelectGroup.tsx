import { ChangeEvent } from "react"

export type Option = {
    label: string
    value: string | number
}

type InputGroupProps = {
    id?: string
    name: string
    value: string | number
    placeholder: string
    label: string
    options?: Option[]
    disable?: boolean
    isHorizontal?: boolean
    onChangeFnc: (e: ChangeEvent<HTMLSelectElement>) => void
}

export default function SelectGroup({ 
    name, 
    id = name, 
    value, 
    placeholder,
    label,
    onChangeFnc, 
    options = [],
    disable = false,
    isHorizontal = false
} : InputGroupProps) {
    return (
        <div className={isHorizontal ? 'condition-container' : `input-group`}>
            <label htmlFor={id}>{label}</label>
            <select disabled={disable} value={value} onChange={onChangeFnc} name={name} id={id}>
                <option value="">{placeholder}</option>
                {options.map((option, index) => (
                    <option key={index} value={option.value}>
                        {option.label}
                    </option>
                ))}
            </select>
        </div>
    )
}
